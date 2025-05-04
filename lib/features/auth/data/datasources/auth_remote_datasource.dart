import 'dart:developer';

import 'package:blog_app/core/errors/server_exception.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/data/repository/firestore_auth_repoository_impl.dart';
import 'package:blog_app/features/blog/data/datsources/blog_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final SharedPreferences sharedPref;
  final BlogRemoteDataSource blogRemoteDataSource;
  AuthRemoteDataSourceImpl({
    required this.firebaseAuthClient,
    required this.firestoreAuthRepoositoryImpl,
    required this.blogRemoteDataSource,
    required this.sharedPref,
  });

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
          'userEmail': email
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
      await sharedPref.setStringList('savedBlogs', []);

      log('user signed up');

      return userModel;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

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

      await blogRemoteDataSource.getSavedBlog(response.user!.uid);
            
            log('user logged in');


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
  Future<void> logUserOut() async {
    try {
      await firebaseAuthClient.signOut();
            log('user logged out');

      return;
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }
}
