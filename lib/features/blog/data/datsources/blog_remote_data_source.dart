import 'dart:developer';
import 'dart:io';
import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/errors/server_exception.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract interface class BlogRemoteDataSource {
  Future<void> uploadBlog(BlogModel blog);

  Future<String?> uploadBlogImage(File image, String uniqueId);

  Future<List<BlogModel>> fetchBlog();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  BlogRemoteDataSourceImpl({
    required this.firestore,
    required this.fireStorage,
  });
  final FirebaseFirestore firestore;
  final FirebaseStorage fireStorage;

  @override
  Future<void> uploadBlog(BlogModel blog) async {
    final ref = firestore.collection('blogs').doc();

    try {
      await ref.set({
        'blogId': ref.id,
        'blogTitle': blog.blogTitle,
        'blogContent': blog.blogContent,
        'imageUrl': blog.blogImageUrl,
        'blogTopics': blog.blogTopics,
        'uploadedAt': Timestamp.fromDate(blog.updatedAt),
        'uploaderID': blog.uploaderId
      });
    } catch (err) {
      Failure(message: err.toString());
    }
  }

  @override
  Future<String?> uploadBlogImage(File image, String uniqueId) async {
    final ref = fireStorage.ref('blog-images').child(uniqueId);
    try {
      await ref.putFile(image);

      final String imageUrl = await ref.getDownloadURL();

      if (imageUrl != null) {
        return imageUrl;
      }
      return null;
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<List<BlogModel>> fetchBlog() async {
    log('inside fetchblog datasource');
    try {
      final ref = firestore.collection('blogs');

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
}
