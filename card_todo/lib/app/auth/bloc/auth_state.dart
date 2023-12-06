part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthDataState extends AuthState {
  const AuthDataState({required this.isPasswordvisible});

  final bool isPasswordvisible;

  @override
  List<Object> get props => [isPasswordvisible];

  AuthDataState copyWith({bool? isPasswordvisible}) {
    return AuthDataState(
      isPasswordvisible: isPasswordvisible ?? this.isPasswordvisible,
    );
  }
}

class AuthFailureState extends AuthState {
  const AuthFailureState();
  @override
  List<Object?> get props => [];
}

class AuthSuccessState extends AuthState {
  const AuthSuccessState();

  @override
  List<Object?> get props => [];
}
