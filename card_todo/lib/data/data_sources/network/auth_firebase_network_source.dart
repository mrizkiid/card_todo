import 'package:card_todo/core/error/failures.dart';
import 'package:card_todo/core/error/firebase_failure.dart';
import 'package:card_todo/core/responses/data_state.dart';
import 'package:card_todo/domain/repositories/auth_repo.dart';
import 'package:card_todo/utils/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class AuthFirebase extends AuthRepo {}

class AuthFirebaseImpl extends AuthFirebase with FirebaseServices {
  @override
  Future<DataState<Failure, void>> signIn(
      {required String email, required String password}) async {
    try {
      firebase_auth.UserCredential userCredential =
          await signInFirebase(email, password);

      if (userCredential.user == null) {
        throw Exception('Sign in failed: The user is null after sign up.');
      }

      return DataSuccess();
    } catch (e) {
      return DataFailed(
        FirebaseFailure(
          messageError: e.toString(),
        ),
      );
    }
  }

  @override
  Future<DataState<Failure, void>> signUp(
      {required String email, required String password}) async {
    try {
      firebase_auth.UserCredential userCredential =
          await signInFirebase(email, password);

      if (userCredential.user == null) {
        throw Exception('Sign up failed: The user is null after sign up.');
      }

      return DataSuccess();
    } catch (e) {
      return DataFailed(
        FirebaseFailure(
          messageError: e.toString(),
        ),
      );
    }
  }

  @override
  Future<DataState<Failure, void>> logOut() async {
    try {
      await signOutFirebase();
      return DataSuccess();
    } catch (e) {
      return DataFailed(
        FirebaseFailure(
          messageError: e.toString(),
        ),
      );
    }
  }
}
