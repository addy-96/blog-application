import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_reppsitory.dart';
import 'package:fpdart/fpdart.dart';


class DeleteBlog implements Usecase<bool, DeleteBlogParams> {
  DeleteBlog({required this.blogReppsitory});
  final BlogReppsitory blogReppsitory;
  @override
  Future<Either<Failure, bool>> call(DeleteBlogParams params) async {
    return await blogReppsitory.deleteBlogs(params.blogId);
  }
}

class DeleteBlogParams {
  DeleteBlogParams({required this.blogId});
  final String blogId;
}
