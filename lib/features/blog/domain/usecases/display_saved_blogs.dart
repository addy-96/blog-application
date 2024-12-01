import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_reppsitory.dart';
import 'package:fpdart/fpdart.dart';

class DisplaySavedBlogs implements Usecase<List<Blog>, NoParams> {
  DisplaySavedBlogs({required this.blogReppsitory});
  final BlogReppsitory blogReppsitory;
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) {
    return blogReppsitory.displaySavedBlogs();
  }
}

class NoParams {}
