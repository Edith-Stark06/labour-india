import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _db.collection('Labour').add({
        'name': name,
        'email': email,
        'password': password,
      });
    } catch (e) {
      print("Error adding document: $e");
      throw e;
    }
  }

  Future<DocumentSnapshot?> getUserByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('Labour')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      }
    } catch (e) {
      print("Error fetching user: $e");
      throw e;
    }
    return null;
  }
}
