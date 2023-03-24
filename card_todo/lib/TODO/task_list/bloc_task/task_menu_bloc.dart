import 'package:bloc/bloc.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:equatable/equatable.dart';

part 'task_menu_event.dart';
part 'task_menu_state.dart';

class TaskMenuBloc extends Bloc<TaskMenuEvent, TaskMenuState> {
  List<TaskList> taskList = [];

  //method for ordering list it will return lis of taskList
  List<TaskList> orderList({required List<TaskList> taskList}) {
    List<TaskList> listFalse =
        taskList.where((element) => element.isChecked == false).toList();
    List<TaskList> listTrue =
        taskList.where((element) => element.isChecked == true).toList();
    taskList = [...listFalse, ...listTrue];
    return taskList;
  }

  // Method for finding listTrue
  List<TaskList> findTaskListTrue({required List<TaskList> taskList}) {
    return taskList.where((element) => element.isChecked == true).toList();
  }

  // Method for finding listFalse
  List<TaskList> findTaskListFalse({required List<TaskList> taskList}) {
    return taskList.where((element) => element.isChecked == false).toList();
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

    on<TaskReorderedButton>((event, emit) {
      List<TaskList> taskListTrue =
          taskList.where((element) => element.isChecked == true).toList();
      emit(TaskReorderState(taskList: taskList, taskListTrue: taskListTrue));
    });

    on<TaskReorderedProcess>((event, emit) {
      List<TaskList> taskListTrue = findTaskListTrue(taskList: taskList);
      int newIndex = event.newIndex;

      // remove and put in tile
      final TaskList tile = taskListTrue.removeAt(event.oldIndex);
      // place the tile in new position
      taskListTrue.insert(newIndex, tile);
      emit(TaskReorderState(taskList: taskList, taskListTrue: taskListTrue));
    });

    on<TaskSave>((event, emit) {
      if (state is TaskReorderState) {
        final currentState = state as TaskReorderState;
        taskList = [
          ...currentState.taskListTrue,
          ...findTaskListFalse(taskList: taskList)
        ];
      }
      emit(TaskState(taskList: taskList));
    });
  }
}
