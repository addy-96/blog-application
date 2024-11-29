import 'dart:developer';

import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class FirestoreAuthRemoteDatasource {
  Future<void> storeUserDataAfterAuth({
    required Map<String, dynamic> userData,
    required String userId,
  });

  Future<UserModel> getUserData({
    required String userID,
  });
}

class FirestoreeAuthRemoteDtaSourceImpl
    implements FirestoreAuthRemoteDatasource {
  final FirebaseFirestore firestore;

  FirestoreeAuthRemoteDtaSourceImpl({required this.firestore});

  @override
  Future<void> storeUserDataAfterAuth({
    required Map<String, dynamic> userData,
    required String userId,
  }) async {


    
    await firestore.collection('users').doc(userId).set({
      'username': userData['username'],
      'userId': userId,
      'createdAt': FieldValue.serverTimestamp(),
      'userEmail': userData['userEmail'],
      'userAppData': {'savedPost': <String>[]}
    });
  }

  @override
  Future<UserModel> getUserData({required String userID}) async {
    final response = await firestore.collection('users').doc(userID).get();

    final username = response.data()!['username'];
    final userEmail = response.data()!['userEmail'];

    return UserModel(
      id: userID,
      email: userEmail,
      name: username,
    );
  }
}
