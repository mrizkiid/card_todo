import 'package:card_todo/core/error/failures.dart';
import 'package:card_todo/core/responses/data_state.dart';

abstract class AuthRepo {
  Future<DataState<Failure, void>> signIn(
      {required String email, required String password});
  Future<DataState<Failure, void>> signUp(
      {required String email, required String password});
  Future<DataState<Failure, void>> logOut();
}
