import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/errors/server_exception.dart';
import 'package:blog_app/features/auth/data/datasources/firestore_auth_remote_datasource.dart';
import 'package:blog_app/features/auth/domain/repository/firestore_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class FirestoreAuthRepoositoryImpl implements FirestoreAuthRepository {
  final FirestoreAuthRemoteDatasource firestoreAuthRemoteDatasource;

  FirestoreAuthRepoositoryImpl({
    required this.firestoreAuthRemoteDatasource,
  });

  @override
  Future<Either<Failure, void>> storeUserDataAfterAuth(
      {required Map<String, dynamic> userDataMap,
      required String userId}) async {
    try {
      await firestoreAuthRemoteDatasource.storeUserDataAfterAuth(
        userData: userDataMap,
        userId: userId,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(
        Failure(
          message: e.message,
        ),
      );
    }
  }
}
