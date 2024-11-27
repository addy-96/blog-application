import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_reppsitory.dart';
import 'package:fpdart/fpdart.dart';

class GetUsername implements Usecase<Future<String> , GetUserNameParams> {
  GetUsername({required this.blogReppsitory});

  final BlogReppsitory blogReppsitory;

  @override
  Future<Either<Failure, Future<String>>> call(GetUserNameParams params) async {
    return blogReppsitory.getUserName(params.userID);
  }
}

class GetUserNameParams {
  GetUserNameParams({required this.userID});
  final String userID;
}
