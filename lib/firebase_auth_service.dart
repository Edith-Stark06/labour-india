import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return credential;
    } on FirebaseAuthException catch (e) {

      print(e.code);
      return null; // Indicate unsuccessful login
    }
  }
}
