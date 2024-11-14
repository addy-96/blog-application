import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class FirestoreAuthRemoteDatasource {
  Future<void> storeUserDataAfterAuth({
    required Map<String, dynamic> userData,
    required String userId,
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
    });
  }
}
