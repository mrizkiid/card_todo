part of 'button_animation_bloc.dart';

abstract class ButtonAnimationEvent extends Equatable {
  const ButtonAnimationEvent();

  @override
  List<Object> get props => [];
}

class MainmenuInitialEvent extends ButtonAnimationEvent {}

class ActionEvent extends ButtonAnimationEvent {}

class ActionDelete extends ButtonAnimationEvent {}

class ActionReorder extends ButtonAnimationEvent {}

class ActionAdd extends ButtonAnimationEvent {}

class DoneEvent extends ButtonAnimationEvent {
  final bool? isSave;

  const DoneEvent({this.isSave});
}

class CancelEvent extends ButtonAnimationEvent {}
