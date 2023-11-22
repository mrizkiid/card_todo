part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PasswordState extends AuthState {
  const PasswordState(this.isvisible);
  final bool isvisible;

  @override
  List<Object> get props => [isvisible];
}
