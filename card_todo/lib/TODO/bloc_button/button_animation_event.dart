part of 'button_animation_bloc.dart';

abstract class ButtonAnimationEvent extends Equatable {
  const ButtonAnimationEvent();

  @override
  List<Object> get props => [];
}

class ButtonMainmenuInitialEvent extends ButtonAnimationEvent {}

class ButtonActionEvent extends ButtonAnimationEvent {
  final bool isAction;
  const ButtonActionEvent({required this.isAction});
}

class ButtonActionDelete extends ButtonAnimationEvent {
  const ButtonActionDelete();
}

class ButtonActionReorder extends ButtonAnimationEvent {
  const ButtonActionReorder();
}

class ButtonActionAdd extends ButtonAnimationEvent {}

class ButtonDoneEvent extends ButtonAnimationEvent {
  final bool isSave;
  const ButtonDoneEvent({required this.isSave});

  @override
  List<Object> get props => [isSave];
}

class ButtonCancelEvent extends ButtonAnimationEvent {}
