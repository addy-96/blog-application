import 'package:blog_app/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class FirestoreAuthRepository {
  Future<Either<Failure, void>> storeUserDataAfterAuth({
    required Map<String, dynamic> userDataMap,
    required String userId,
  });
}
