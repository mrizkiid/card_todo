part of 'button_animation_bloc.dart';

abstract class ButtonAnimationState extends Equatable {
  final bool isActionPressed;
  final bool isShowPressed;
  final ActionEnum actionEnum;

  const ButtonAnimationState(
      {required this.isActionPressed,
      required this.isShowPressed,
      required this.actionEnum});
  @override
  List<Object?> get props => [isActionPressed, isShowPressed, actionEnum];
}

class ButtonAnimationInitial extends ButtonAnimationState {
  const ButtonAnimationInitial(
      {required super.isActionPressed,
      required super.isShowPressed,
      required super.actionEnum});
}

class MainmenuInitial extends ButtonAnimationState {
  const MainmenuInitial(
      {required super.actionEnum,
      required super.isActionPressed,
      required super.isShowPressed});
}

class ActionState extends ButtonAnimationState {
  const ActionState(
      {required super.isActionPressed,
      required super.isShowPressed,
      required super.actionEnum});
}

class ReorderState extends ButtonAnimationState {
  const ReorderState(
      {required super.isActionPressed,
      required super.isShowPressed,
      required super.actionEnum});
}

class DeleteState extends ButtonAnimationState {
  const DeleteState(
      {required super.isActionPressed,
      required super.isShowPressed,
      required super.actionEnum});
}

class DeleteMainMenuState extends ButtonAnimationState {
  const DeleteMainMenuState(
      {required super.isActionPressed,
      required super.isShowPressed,
      required super.actionEnum});
}

class CancelState extends ButtonAnimationState {
  const CancelState(
      {required super.isActionPressed,
      required super.isShowPressed,
      required super.actionEnum});
}

class DoneState extends ButtonAnimationState {
  const DoneState(
      {required super.isActionPressed,
      required super.isShowPressed,
      required super.actionEnum,
      this.isSave});

  final bool? isSave;
}
