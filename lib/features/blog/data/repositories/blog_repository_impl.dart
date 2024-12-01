import 'dart:io';

import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/features/blog/data/datsources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_reppsitory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogReppsitory {
  final BlogRemoteDataSource blogRemoteDataSource;
  final FirebaseAuth auth;

  BlogRepositoryImpl({
    required this.blogRemoteDataSource,
    required this.auth,
  });

  @override
  Future<Either<Failure, Blog>> uploadBlog(
    File? image,
    String blogTitle,
    String blogContent,
    List<String> blogTopics,
    DateTime uploadedAt,
  ) async {
    try {
      String? imageUrl;

      final uniqueID = auth.currentUser!.uid + const Uuid().v4();

      if (image != null) {
        imageUrl = await blogRemoteDataSource.uploadBlogImage(image, uniqueID);
      }

      if (image == null) {
        imageUrl = "";
      }

      final uploaderID = auth.currentUser!.uid;

      final blog = BlogModel(
        blogId: uniqueID,
        blogTitle: blogTitle,
        blogContent: blogContent,
        blogImageUrl: imageUrl!,
        blogTopics: blogTopics,
        updatedAt: uploadedAt,
        uploaderId: uploaderID,
      );

      await blogRemoteDataSource.uploadBlog(blog);

      return right(blog);
    } catch (err) {
      return left(
        Failure(
          message: err.toString(),
        ),
      );
    }
  }

  @override
  Either<Failure, Future<List<Blog>>> fetchBlog() {
    try {
      final result = blogRemoteDataSource.fetchBlog();

      return right(result);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Either<Failure, Future<String>> getUserName(String userId) {
    try {
      return right(blogRemoteDataSource.getUserName(userId));
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Either<Failure, Future<void>> saveBlog(String blogId) {
    try {
      return right(blogRemoteDataSource.saveOrUnsaveBlog(blogId));
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Either<Failure, Future<void>> getSavedBlogs(String userID) {
    try {
      return right(blogRemoteDataSource.getSavedBlog(userID));
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BlogModel>>> displaySavedBlogs() async {
    try {
      return right(await blogRemoteDataSource.displaySavedBlogs());
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }
}
