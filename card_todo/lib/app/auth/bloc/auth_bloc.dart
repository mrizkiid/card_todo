import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthLoadingState()) {
    on<PasswordEvent>((event, emit) {
      if (state is AuthDataState) {
        final newState = state as AuthDataState;
        emit(newState.copyWith(isPasswordvisible: !newState.isPasswordvisible));
      }
    });
  }
}
