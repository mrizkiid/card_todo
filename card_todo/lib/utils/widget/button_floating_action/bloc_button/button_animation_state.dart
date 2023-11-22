part of 'button_animation_bloc.dart';

abstract class ButtonAnimationState extends Equatable {
  final ActionEnum actionEnum;

  const ButtonAnimationState({required this.actionEnum});
  @override
  List<Object?> get props => [actionEnum];
}

class ButtonAnimationInitial extends ButtonAnimationState {
  const ButtonAnimationInitial({required super.actionEnum});
}

class ButtonMainmenuInitial extends ButtonAnimationState {
  const ButtonMainmenuInitial({
    required super.actionEnum,
  });
}

class ButtonActionState extends ButtonAnimationState {
  const ButtonActionState({required super.actionEnum, required this.isAction});

  final bool isAction;

  @override
  List<Object?> get props => [isAction];
}

class ButtonAddState extends ButtonAnimationState {
  const ButtonAddState({required super.actionEnum});
}

class ButtonReorderState extends ButtonAnimationState {
  const ButtonReorderState({required super.actionEnum});
}

class ButtonDeleteState extends ButtonAnimationState {
  const ButtonDeleteState({required super.actionEnum});
}

class ButtonDeleteMainMenuState extends ButtonAnimationState {
  const ButtonDeleteMainMenuState({required super.actionEnum});
}

class CancelState extends ButtonAnimationState {
  const CancelState({required super.actionEnum});
}

class ButtonDoneState extends ButtonAnimationState {
  const ButtonDoneState({required super.actionEnum, this.isSave});

  final bool? isSave;
}

class ButtonEmptyState extends ButtonAnimationState {
  const ButtonEmptyState({required super.actionEnum});
}
