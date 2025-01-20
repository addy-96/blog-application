import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/errors/server_exception.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<void> uploadBlog(BlogModel blog);

  Future<String?> uploadBlogImage(File image, String uniqueId);

  Future<List<BlogModel>> fetchBlog();

  Future<String> getUserName(String userId);

  Future<void> saveOrUnsaveBlog(String blogId);

  Future<void> getSavedBlog(String userId);

  Future<List<BlogModel>> displaySavedBlogs();

  Future<bool> deleteBlog(String blogID);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  BlogRemoteDataSourceImpl({
    required this.firestore,
    required this.fireStorage,
    required this.supabase,
    required this.firebaseAuth,
    required this.sharedPref,
  });
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage fireStorage;
  final Supabase supabase;
  final SharedPreferences sharedPref;

  @override
  Future<void> uploadBlog(BlogModel blog) async {
    final blogsRef = firestore.collection('blogs').doc();
    final userID = firebaseAuth.currentUser!.uid;
    final userRef = firestore.collection('users').doc(userID);

    try {
      await blogsRef.set({
        'blogId': blogsRef.id,
        'blogTitle': blog.blogTitle,
        'blogContent': blog.blogContent,
        'imageUrl': blog.blogImageUrl,
        'blogTopics': blog.blogTopics,
        'uploadedAt': Timestamp.fromDate(blog.updatedAt),
        'uploaderID': blog.uploaderId
      });

//update uploaded blogid list in user collection
      await userRef.update(
        {
          'userAppData.uploadedPost': FieldValue.arrayUnion(
            [blogsRef.id],
          ),
        },
      );
    } catch (err) {
      Failure(message: err.toString());
    }
  }

  @override
  Future<String?> uploadBlogImage(File image, String uniqueId) async {
    final path = 'blog-images/$uniqueId';
    final ref = supabase.client.storage.from('blog-app');
    try {
      await ref.upload(path, image);

      final String imageUrl = ref.getPublicUrl(path);

      if (imageUrl.isNotEmpty) {
        return imageUrl;
      }

      return null;
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<List<BlogModel>> fetchBlog() async {
    try {
      final ref =
          firestore.collection('blogs').orderBy('uploadedAt', descending: true);

      final response = await ref.get();

      final List<BlogModel> blogList = [];

      for (var doc in response.docs) {
        final List<String> topicsList = [];

        for (var topic in doc['blogTopics']) {
          topicsList.add(topic);
        }

        final BlogModel blog = BlogModel(
          blogId: doc.id,
          blogTitle: doc['blogTitle'],
          blogContent: doc['blogContent'],
          blogImageUrl: doc['imageUrl'],
          blogTopics: topicsList,
          updatedAt: doc['uploadedAt'].toDate(),
          uploaderId: doc['uploaderID'],
        );

        blogList.add(blog);
      }

      return blogList;
    } catch (err) {
      throw ServerException(
        message: err.toString(),
      );
    }
  }

  @override
  Future<String> getUserName(String userId) async {
    try {
      final response = await firestore.collection('users').doc(userId).get();
      return response['username'];
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<void> saveOrUnsaveBlog(String blogId) async {
    if (firebaseAuth.currentUser == null) {
      throw const ServerException(message: 'How Tf Did you even reach here');
    }

    final userId = firebaseAuth.currentUser!.uid;

    final ref = firestore.collection('users').doc(userId);

    try {
      final userDoc = await ref.get();

      final savedPostList =
          (userDoc.data()?['userAppData']['savedPost'] as List<dynamic>)
                  .map((item) => item.toString())
                  .toList() ??
              [];

      if (savedPostList.contains(blogId)) {
        await ref.update({
          'userAppData.savedPost': FieldValue.arrayRemove([blogId]),
        });
      }
      if (!savedPostList.contains(blogId)) {
        await ref.update({
          'userAppData.savedPost': FieldValue.arrayUnion([blogId]),
        });
      }

      await getSavedBlog(userId);
    } on ServerException catch (err) {
      throw ServerException(message: err.message);
    }
  }

  @override
  Future<void> getSavedBlog(String userId) async {
    final ref = firestore.collection('users').doc(userId);

    try {
      final userDoc = await ref.get();

      final savedPostList =
          (userDoc.data()?['userAppData']['savedPost'] as List<dynamic>)
                  .map((item) => item.toString())
                  .toList() ??
              [];

// setting the savedBlogs to new list ;
      await sharedPref.setStringList('savedBlogs', savedPostList);
    } on ServerException catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<List<BlogModel>> displaySavedBlogs() async {
    try {
      final blogIdList = sharedPref.getStringList('savedBlogs') ?? [];

      final List<BlogModel> blogs = [];

      for (var blogId in blogIdList) {
        final response = await firestore
            .collection('blogs')
            .where('blogId', isEqualTo: blogId)
            .get();

        for (var item in response.docs) {
          final List<String> selectedTopics = [];

          for (var topics in item['blogTopics']) {
            selectedTopics.add(topics as String);
          }

          final blog = BlogModel(
              blogId: blogId,
              blogTitle: item['blogTitle'],
              blogContent: item['blogContent'],
              blogImageUrl: item['imageUrl'],
              blogTopics: selectedTopics,
              updatedAt: item['uploadedAt'].toDate(),
              uploaderId: item['uploaderID']);

          blogs.add(blog);
        }
      }
      return blogs;
    } on ServerException catch (err) {
      throw ServerException(message: err.message);
    }
  }

  @override
  Future<bool> deleteBlog(String blogID) async {
    try {
      final ref = firestore.collection('blogs').doc(blogID);
      final res = await ref.get();

      if (res.data()!['imageUrl'] == "") {
        await ref.delete();
        return true;
      }

      final imageUrl = res.data()!['imageUrl'];

      final Uri uri = Uri.parse(imageUrl);
      final path = uri.pathSegments.sublist(4).join('/');

      log('path $path');

      final response =
          await supabase.client.storage.from('blog-app').remove([path]);

      log(response.length.toString());
      log('image deleted succesfully.......');

      await ref.delete();
      return true;
    } on ServerException catch (err) {
      log(err.toString());
      throw ServerException(message: err.message);
    }
  }
}
