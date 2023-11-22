part of 'password_cubit.dart';

abstract class PasswordState extends Equatable {
  const PasswordState(this.isvisible);
  final bool isvisible;

  @override
  List<Object> get props => [isvisible];
}

class PasswordInitial extends PasswordState {
  const PasswordInitial(super.isvisible);
}

class PasswordChange extends PasswordState {
  const PasswordChange(super.isvisible);
}
