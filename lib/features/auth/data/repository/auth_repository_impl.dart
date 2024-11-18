import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/errors/server_exception.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/datasources/firestore_auth_remote_datasource.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final FirestoreAuthRemoteDatasource firestoreAuthRemoteDatasource;

  const AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.firestoreAuthRemoteDatasource,
  });

  @override
  Future<Either<Failure, User>> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userId = await authRemoteDatasource.logInWithEmailPassword(
        email: email,
        password: password,
      );

      return right(userId);
    } on ServerException catch (e) {
      return left(
        Failure(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userModel = await authRemoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      return right(userModel);
    } on ServerException catch (e) {
      return left(
        Failure(
          message: e.message,
        ),
      );
    }
  }
}
