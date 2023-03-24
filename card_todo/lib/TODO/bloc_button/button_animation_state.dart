part of 'button_animation_bloc.dart';

abstract class ButtonAnimationState extends Equatable {
  // final bool isActionPressed;
  // final bool isShowPressed;
  final ActionEnum actionEnum;

  const ButtonAnimationState(
      {
      //   required this.isActionPressed,
      // required this.isShowPressed,
      required this.actionEnum});
  @override
  List<Object?> get props => [actionEnum];
}

class ButtonAnimationInitial extends ButtonAnimationState {
  const ButtonAnimationInitial(
      {
      //   required super.isActionPressed,
      // required super.isShowPressed,
      required super.actionEnum});
}

class ButtonMainmenuInitial extends ButtonAnimationState {
  const ButtonMainmenuInitial({
    required super.actionEnum,
    // required super.isActionPressed,
    // required super.isShowPressed
  });
}

class ButtonActionState extends ButtonAnimationState {
  const ButtonActionState(
      {
      //   required super.isActionPressed,
      // required super.isShowPressed,
      required super.actionEnum,
      required this.isAction});

  final bool isAction;

  @override
  List<Object?> get props => [isAction];
}

class ButtonReorderState extends ButtonAnimationState {
  const ButtonReorderState(
      {
      //   required super.isActionPressed,
      // required super.isShowPressed,
      required super.actionEnum});
}

class ButtonDeleteState extends ButtonAnimationState {
  const ButtonDeleteState(
      {
      //   required super.isActionPressed,
      // required super.isShowPressed,
      required super.actionEnum});
}

class ButtonDeleteMainMenuState extends ButtonAnimationState {
  const ButtonDeleteMainMenuState(
      {
      //   required super.isActionPressed,
      // required super.isShowPressed,
      required super.actionEnum});
}

class CancelState extends ButtonAnimationState {
  const CancelState(
      {
      //   required super.isActionPressed,
      // required super.isShowPressed,
      required super.actionEnum});
}

class ButtonDoneState extends ButtonAnimationState {
  const ButtonDoneState(
      {
      //   required super.isActionPressed,
      // required super.isShowPressed,
      required super.actionEnum,
      this.isSave});

  final bool? isSave;
}
