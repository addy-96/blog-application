import 'dart:io';
import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogReppsitory {
  Future<Either<Failure, Blog>> uploadBlog(
    File? image,
    String blogTitle,
    String blogContent,
    List<String> blogTopics,
    DateTime uploadedAt,
  );

  Either<Failure, Future<List<Blog>>> fetchBlog();

  Either<Failure, Future<String>> getUserName(String userID);

  Either<Failure, void> saveBlog(String blogId);

  Either<Failure, Future<void>> getSavedBlogs(String userID);

  Future<Either<Failure, List<BlogModel>>> displaySavedBlogs();
}
