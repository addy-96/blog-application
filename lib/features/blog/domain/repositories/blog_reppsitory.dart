import 'dart:io';

import 'package:blog_app/core/errors/failure.dart';
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
}
