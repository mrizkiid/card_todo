import 'package:bloc/bloc.dart';
import 'package:card_todo/UTILS/static/enum_todo.dart';
import 'package:equatable/equatable.dart';

part 'button_animation_event.dart';
part 'button_animation_state.dart';

class ButtonAnimationBloc
    extends Bloc<ButtonAnimationEvent, ButtonAnimationState> {
  late ActionEnum actionEnum;
  late WhichTodoBloc whichTodoBloc;

  ButtonAnimationBloc({required this.whichTodoBloc})
      : super(const ButtonAnimationInitial(actionEnum: ActionEnum.action)) {
    // on<ButtonActionEvent>((event, emit) {
    //   bool isAction = true;
    //   if (state is ButtonActionState) {
    //     ButtonActionState currentState = state as ButtonActionState;
    //     isAction = !currentState.isAction;
    //   }
    //   actionEnum = ActionEnum.action;
    //   emit(
    //     ButtonActionState(actionEnum: actionEnum, isAction: isAction),
    //   );
    // });

    // on<ButtonActionAdd>((event, emit) {
    //   actionEnum = ActionEnum.action;
    //   emit(ButtonAddState(actionEnum: actionEnum));
    // });

    // on<ButtonActionReorder>((event, emit) {
    //   actionEnum = ActionEnum.reorder;
    //   emit(ButtonReorderState(actionEnum: actionEnum));
    // });

    // on<ButtonActionDelete>((event, emit) {
    //   actionEnum = ActionEnum.delete;
    //   emit(ButtonDeleteState(actionEnum: actionEnum));
    // });

    // on<ButtonDoneEvent>((event, emit) {
    //   actionEnum = ActionEnum.action;
    //   emit(
    //     ButtonDoneState(
    //       actionEnum: actionEnum,
    //     ),
    //   );
    // });

    // on<ButtonCancelEvent>((event, emit) {
    //   actionEnum = ActionEnum.action;
    //   emit(
    //     ButtonDoneState(
    //       actionEnum: actionEnum,
    //     ),
    //   );
    // });

    // on<ButtonEmptyEvent>((event, emit) {
    //   emit(const ButtonEmptyState(
    //     actionEnum: ActionEnum.add,
    //   ));
    // });
  }
}
