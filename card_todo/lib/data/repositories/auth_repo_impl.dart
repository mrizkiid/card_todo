import 'package:card_todo/core/error/failures.dart';
import 'package:card_todo/core/responses/data_state.dart';
import 'package:card_todo/data/data_sources/network/auth_firebase_network_source.dart';
import 'package:card_todo/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._authFirebase);

  final AuthFirebase _authFirebase;

  @override
  Future<DataState<Failure, void>> logOut() async {
    return _authFirebase.logOut();
  }

  @override
  Future<DataState<Failure, void>> signIn(
      {required String email, required String password}) async {
    return _authFirebase.signIn(email: email, password: password);
  }

  @override
  Future<DataState<Failure, void>> signUp(
      {required String email, required String password}) async {
    return _authFirebase.signUp(email: email, password: password);
  }
}
