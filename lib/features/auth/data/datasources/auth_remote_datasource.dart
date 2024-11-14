import 'package:blog_app/core/errors/server_exception.dart';
import 'package:blog_app/features/auth/data/repository/firestore_auth_repoository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDatasource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> logInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuthClient;
  final FirestoreAuthRepoositoryImpl firestoreAuthRepoositoryImpl;
  AuthRemoteDataSourceImpl({
    required this.firebaseAuthClient,
    required this.firestoreAuthRepoositoryImpl,
  });

  @override
  Future<String> logInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await firebaseAuthClient.signInWithEmailAndPassword(
          email: email, password: password);
      if (response.user == null) {
        throw const ServerException(message: 'User is null');
      }

      return response.user!.uid;
    } on ServerException catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuthClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw const ServerException(message: 'User is null');
      }

      if (response.user != null) {
        final Map<String, dynamic> userData = {
          'username': name,
          'userId': response.user!.uid,
        };
        firestoreAuthRepoositoryImpl.storeUserDataAfterAuth(
          userDataMap: userData,
          userId: response.user!.uid,
        );
      }
      return response.user!.uid;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
