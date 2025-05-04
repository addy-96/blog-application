import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/internet_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/datasources/firestore_auth_remote_datasource.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireauth;
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final FirestoreAuthRemoteDatasource firestoreAuthRemoteDatasource;
  final InternetChecker internetChecker;

  const AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.internetChecker,
    required this.firestoreAuthRemoteDatasource,
  });

  @override
  Future<Either<Failure, User>> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    if (!await (internetChecker.isConnected)) {
      return left(Failure(message: 'No Internet Connection !'));
    }
    try {
      final userModel = await authRemoteDatasource.logInWithEmailPassword(
        email: email,
        password: password,
      );

      return right(userModel);
    } on fireauth.FirebaseAuthException catch (e) {
      return left(
        Failure(
          message: e.message!,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    if (!await (internetChecker.isConnected)) {
      return left(Failure(message: 'No Internet Connection !'));
    }
    try {
      final userModel = await authRemoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      return right(userModel);
    } on fireauth.FirebaseAuthException catch (e) {
      return left(
        Failure(
          message: e.message!,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> logUserOut() async {
    if (!await (internetChecker.isConnected)) {
      return left(Failure(message: 'No Internet Connection !'));
    }
    try {
      await authRemoteDatasource.logUserOut();
      // ignore: void_checks
      return right(unit);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }
}
