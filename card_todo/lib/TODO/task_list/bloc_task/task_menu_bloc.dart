import 'package:bloc/bloc.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:equatable/equatable.dart';

part 'task_menu_event.dart';
part 'task_menu_state.dart';

class TaskMenuBloc extends Bloc<TaskMenuEvent, TaskMenuState> {
  List<TaskList> taskList = [];

  //method for ordering list for
  List<TaskList> orderList({required List<TaskList> taskList}) {
    List<TaskList> listFalse =
        taskList.where((element) => element.isChecked == false).toList();
    List<TaskList> listTrue =
        taskList.where((element) => element.isChecked == true).toList();
    taskList = [...listFalse, ...listTrue];
    return taskList;
  }

  TaskMenuBloc({required TodoData todoData})
      : super(TaskMenuInitial(taskList: [...todoData.tasklist])) {
    on<TaskInitialList>((event, emit) {
      taskList = orderList(taskList: event.taskList);
      emit(TaskState(taskList: taskList));
    });

    on<TaskEvent>((event, emit) {
      bool isChecked = !event.isChecked;
      taskList = [...state.taskList];
      taskList[event.index] =
          TaskList(isChecked: isChecked, title: event.title);
      taskList = orderList(taskList: taskList);
      todoData.tasklist = [...taskList];
      emit(TaskState(taskList: taskList));
    });
  }
}
