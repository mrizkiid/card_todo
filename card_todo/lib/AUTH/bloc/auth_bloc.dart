import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<PasswordEvent>((event, emit) {
      var newstate = state as PasswordState;
      bool isvisible = newstate.isvisible;
      isvisible = !isvisible;
      emit(PasswordState(isvisible));
    });
  }
}
