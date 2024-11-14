import 'package:blog_app/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType , Params> {
  Future<Either<Failure, String>> call(Params params);
}
