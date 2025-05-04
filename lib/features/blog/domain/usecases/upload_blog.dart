import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_reppsitory.dart';

class UploadBlog implements Usecase<Blog, BlogParams> {
  final BlogReppsitory blogReppsitory;

  UploadBlog({
    required this.blogReppsitory,
  });

  @override
  Future<Either<Failure, Blog>> call(BlogParams params) async {
    return await blogReppsitory.uploadBlog(
      params.image,
      params.blogTitle,
      params.blogContent,
      params.blogtopics,
      params.uploadedAt,
    );
  }
}

class BlogParams {
  final File? image;
  final String blogTitle;
  final List<String> blogtopics;
  final String blogContent;
  final DateTime uploadedAt;

  BlogParams({
    required this.image,
    required this.blogTitle,
    required this.blogtopics,
    required this.blogContent,
    required this.uploadedAt,
  });
}
