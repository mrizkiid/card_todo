import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit(bool initialvisible) : super(PasswordInitial(initialvisible));

  void passwordEvent() {
    bool isvisible = state.isvisible;
    isvisible = !isvisible;
    emit(PasswordChange(isvisible));
  }

  void passwordInitialEvent() {
    emit(const PasswordChange(true));
  }
}
