import 'package:bloc/bloc.dart';
import 'package:card_todo/TODO/utils/widget/widget_button_animation_helper.dart';
import 'package:equatable/equatable.dart';

part 'button_animation_event.dart';
part 'button_animation_state.dart';

enum WhichBloc {
  tittleTask,
}

class ButtonAnimationBloc
    extends Bloc<ButtonAnimationEvent, ButtonAnimationState> {
  late ActionEnum actionEnum;

  ButtonAnimationBloc()
      : super(const ButtonAnimationInitial(
            isActionPressed: false,
            isShowPressed: false,
            actionEnum: ActionEnum.action)) {
    //
    on<ActionEvent>((event, emit) {
      bool isPressed = !state.isActionPressed;
      actionEnum = ActionEnum.action;
      emit(ActionState(
          actionEnum: actionEnum,
          isActionPressed: isPressed,
          isShowPressed: state.isShowPressed));
    });

    on<ActionAdd>((event, emit) {
      bool isActionPressed = !state.isActionPressed;
      actionEnum = ActionEnum.add;
      emit(ReorderState(
          isActionPressed: isActionPressed,
          isShowPressed: state.isShowPressed,
          actionEnum: actionEnum));
    });

    on<ActionReorder>((event, emit) {
      bool isActionPressed = !state.isActionPressed;
      bool isShowPressed = !state.isShowPressed;
      actionEnum = ActionEnum.reorder;
      emit(ReorderState(
          isActionPressed: isActionPressed,
          isShowPressed: isShowPressed,
          actionEnum: actionEnum));
    });

    on<ActionDelete>((event, emit) {
      bool isPressed = !state.isActionPressed;
      bool isShowPressed = !state.isShowPressed;
      actionEnum = ActionEnum.delete;
      emit(DeleteState(
          isActionPressed: isPressed,
          isShowPressed: isShowPressed,
          actionEnum: actionEnum));
    });

    on<DoneEvent>((event, emit) {
      bool isPressed = !state.isShowPressed;
      actionEnum = ActionEnum.action;
      emit(DoneState(
          actionEnum: actionEnum,
          isShowPressed: isPressed,
          isActionPressed: state.isActionPressed));
    });

    on<CancelEvent>((event, emit) {
      bool isPressed = !state.isShowPressed;
      actionEnum = ActionEnum.action;
      emit(DoneState(
          actionEnum: actionEnum,
          isShowPressed: isPressed,
          isActionPressed: state.isActionPressed));
    });
  }
}
