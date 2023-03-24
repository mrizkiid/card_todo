import 'package:bloc/bloc.dart';
// import 'package:card_todo/TODO/utils/widget/widget_button_animation_helper.dart';
import 'package:card_todo/UTILS/static/enum_todo.dart';
import 'package:equatable/equatable.dart';

part 'button_animation_event.dart';
part 'button_animation_state.dart';

class ButtonAnimationBloc
    extends Bloc<ButtonAnimationEvent, ButtonAnimationState> {
  late ActionEnum actionEnum;
  late WhichTodoBloc whichTodoBloc;

  ButtonAnimationBloc({required this.whichTodoBloc})
      : super(const ButtonAnimationInitial(
            isActionPressed: false,
            isShowPressed: false,
            actionEnum: ActionEnum.action)) {
    //
    on<ButtonActionEvent>((event, emit) {
      bool isPressed = event.isPressed;
      actionEnum = ActionEnum.action;
      emit(ButtonActionState(
          actionEnum: actionEnum,
          isActionPressed: isPressed,
          isShowPressed: state.isShowPressed));
    });

    on<ButtonActionAdd>((event, emit) {
      bool isActionPressed = !state.isActionPressed;
      actionEnum = ActionEnum.add;
      emit(ButtonReorderState(
          isActionPressed: isActionPressed,
          isShowPressed: state.isShowPressed,
          actionEnum: actionEnum));
    });

    on<ButtonActionReorder>((event, emit) {
      bool isActionPressed = event.isPressed;
      bool isShowPressed = !state.isShowPressed;
      actionEnum = ActionEnum.reorder;
      emit(ButtonReorderState(
          isActionPressed: isActionPressed,
          isShowPressed: isShowPressed,
          actionEnum: actionEnum));
    });

    on<ButtonActionDelete>((event, emit) {
      bool isPressed = event.isPressed;
      bool isShowPressed = !state.isShowPressed;
      actionEnum = ActionEnum.delete;
      emit(ButtonDeleteState(
          isActionPressed: isPressed,
          isShowPressed: isShowPressed,
          actionEnum: actionEnum));
    });

    on<ButtonDoneEvent>((event, emit) {
      bool isPressed = !state.isShowPressed;
      actionEnum = ActionEnum.action;
      emit(ButtonDoneState(
          actionEnum: actionEnum,
          isShowPressed: isPressed,
          isActionPressed: state.isActionPressed));
    });

    on<ButtonCancelEvent>((event, emit) {
      bool isPressed = !state.isShowPressed;
      actionEnum = ActionEnum.action;
      emit(ButtonDoneState(
          actionEnum: actionEnum,
          isShowPressed: isPressed,
          isActionPressed: state.isActionPressed));
    });
  }
}
