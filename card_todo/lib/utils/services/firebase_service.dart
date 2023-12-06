import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

mixin class FirebaseServices {
  Future<firebase_auth.UserCredential> signInFirebase(
      String email, String password) async {
    return await firebase_auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<firebase_auth.UserCredential> signUpFirebase(
      String email, String password) async {
    return await firebase_auth.FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOutFirebase() async {
    firebase_auth.FirebaseAuth.instance.signOut();
  }

  Stream<firebase_auth.User?> get firebaseStream {
    return firebase_auth.FirebaseAuth.instance.authStateChanges();
  }

  void dispose() {}
}
