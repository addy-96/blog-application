
import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_reppsitory.dart';
import 'package:fpdart/fpdart.dart';

class FetchBlog implements Usecase<Future<List<Blog>>, BlogParams> {
  final BlogReppsitory blogReppsitory;

  FetchBlog({required this.blogReppsitory});

  @override
  Future<Either<Failure, Future<List<Blog>>>> call(BlogParams params) async {
    return blogReppsitory.fetchBlog();
  }
}

class BlogParams {}
