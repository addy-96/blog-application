import 'package:blog_app/core/errors/server_exception.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/data/repository/firestore_auth_repoository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> logUserOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuthClient;
  final FirestoreAuthRepoositoryImpl firestoreAuthRepoositoryImpl;
  AuthRemoteDataSourceImpl({
    required this.firebaseAuthClient,
    required this.firestoreAuthRepoositoryImpl,
  });

  @override
  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuthClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw const ServerException(message: 'User is null');
      }

      final result = await firestoreAuthRepoositoryImpl.getUserData(
        userID: response.user!.uid,
      );

      return result.fold(
        (l) {
          throw const ServerException(message: 'Some error Occured');
        },
        (r) {
          return UserModel(
            id: r.id,
            email: r.email,
            name: r.name,
          );
        },
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
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

      final userModel = UserModel(
        id: response.user!.uid,
        email: email,
        name: name,
      );
      return userModel;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> logUserOut() async {
    try {
      await firebaseAuthClient.signOut();
      return;
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }
}
