import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class FirestoreAuthRepository {
  Future<Either<Failure, void>> storeUserDataAfterAuth({
    required Map<String, dynamic> userDataMap,
    required String userId,
  });

  Future<Either<Failure, User>> getUserData({
    required String userID,
  });
}
