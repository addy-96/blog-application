import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_reppsitory.dart';
import 'package:fpdart/fpdart.dart';

class SaveBlog implements Usecase<void, SaveBlogParams> {
  SaveBlog({
    required this.blogReppsitory,
  });
  final BlogReppsitory blogReppsitory;

  @override
  Future<Either<Failure, void>> call(SaveBlogParams params) async {
    return blogReppsitory.saveBlog(params.blogId);
  }
}

class SaveBlogParams {
  final String blogId;
  SaveBlogParams({
    required this.blogId,
  });
}
