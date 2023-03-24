part of 'button_animation_bloc.dart';

abstract class ButtonAnimationEvent extends Equatable {
  const ButtonAnimationEvent();

  @override
  List<Object> get props => [];
}

class ButtonMainmenuInitialEvent extends ButtonAnimationEvent {}

class ButtonActionEvent extends ButtonAnimationEvent {
  final bool isPressed;

  const ButtonActionEvent(this.isPressed);
}

class ButtonActionDelete extends ButtonAnimationEvent {
  final bool isPressed;

  const ButtonActionDelete(this.isPressed);
}

class ButtonActionReorder extends ButtonAnimationEvent {
  final bool isPressed;

  const ButtonActionReorder(this.isPressed);
}

class ButtonActionAdd extends ButtonAnimationEvent {}

class ButtonDoneEvent extends ButtonAnimationEvent {
  final bool? isSave;

  const ButtonDoneEvent({this.isSave});
}

class ButtonCancelEvent extends ButtonAnimationEvent {}
