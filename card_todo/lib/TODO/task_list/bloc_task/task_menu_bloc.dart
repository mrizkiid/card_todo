import 'package:bloc/bloc.dart';
import 'package:card_todo/DATA/model/modelTodo.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:equatable/equatable.dart';

part 'task_menu_event.dart';
part 'task_menu_state.dart';

class TaskMenuBloc extends Bloc<TaskMenuEvent, TaskMenuState> {
  late List<TaskList> taskList;
  late List<int> isDeleteList;
  String keyValue = '';
  String titleTask = '';

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

  void changedToNewList(List<TaskList> taskListNew) {
    taskList = [...taskListNew];
  }

  void saveTask(
      {required TodoData todoData,
      required String keyValue,
      required String titleTask,
      required List<TaskList> taskListNew}) {
    todoData.listTask = taskListNew;
    todoData.saveTaskList(
        keyValue: keyValue, title: titleTask, taskList: taskListNew);
  }

  TaskMenuBloc({required TodoData todoData})
      : super(const TaskMenuInitial(taskList: [])) {
    on<TaskInitialList>((event, emit) async {
      keyValue = event.keyValue ?? keyValue;
      titleTask = event.title ?? keyValue;
      taskList = [
        ...await todoData.getTaskList(title: titleTask, keyValue: keyValue)
      ];
      taskList = orderList(taskList: state.taskList);
      todoData.listTask = [...taskList];
      emit(TaskState(taskList: taskList));
    });

    on<TaskEvent>((event, emit) {
      bool isChecked = !event.isChecked;
      taskList = [...state.taskList];
      taskList[event.index] =
          TaskList(isChecked: isChecked, title: event.title);
      taskList = orderList(taskList: taskList);
      // todoData.saveTaskList(
      //     keyValue: keyValue, title: titleTask, taskList: [...taskList]);
      saveTask(
          todoData: todoData,
          keyValue: keyValue,
          titleTask: titleTask,
          taskListNew: [...taskList]);
      emit(TaskState(taskList: taskList));
    });

    ///
    /// Task Reordered
    ///
    on<TaskReordered>((event, emit) {
      bool isOrdered = event.isOrdered;
      taskList = [...state.taskList];
      List<TaskList> taskListFalse =
          findTaskListFalse(taskList: state.taskList);
      emit(TaskReorderState(
          taskList: taskList,
          taskListFalse: taskListFalse,
          isOrdered: isOrdered));
    });

    on<TaskReorderedProcess>((event, emit) {
      taskList = [...state.taskList];
      List<TaskList> taskListFalse = [];
      if (state is TaskReorderState) {
        var currentState = state as TaskReorderState;
        taskListFalse = [...currentState.taskListFalse];
      }
      int newIndex = event.newIndex;

      // remove and put in tile
      final TaskList tile = taskListFalse.removeAt(event.oldIndex);
      // place the tile in new position
      taskListFalse.insert(newIndex, tile);
      emit(TaskReorderState(
          taskList: taskList, taskListFalse: taskListFalse, isOrdered: true));
    });

    on<TaskReorderSave>((event, emit) {
      if (state is TaskReorderState) {
        final currentState = state as TaskReorderState;
        taskList = [
          ...currentState.taskListFalse,
          ...findTaskListTrue(taskList: state.taskList)
        ];
        saveTask(
            todoData: todoData,
            keyValue: keyValue,
            titleTask: titleTask,
            taskListNew: [...taskList]);
      }
      changedToNewList(taskList);
      emit(TaskSaveState(taskList: taskList));
    });

    ///
    /// Task Delete
    ///
    on<TaskDelete>((event, emit) {
      bool isDelete = event.isDelete;
      taskList = [...state.taskList];
      emit(TaskDeleteState(
          isRedList: List.filled(taskList.length, false),
          isDelete: isDelete,
          taskList: taskList));
    });

    on<TaskDeleteProcess>((event, emit) {
      List<bool> isRedList = [];
      bool isDelete = true;
      int index = event.index;
      if (state is TaskDeleteState) {
        final currentState = state as TaskDeleteState;
        isRedList = [...currentState.isRedList];
        isRedList[index] = !isRedList[index];
        isDelete = currentState.isDelete;
      }

      isDeleteList.add(index);

      changedToNewList(state.taskList);

      emit(TaskDeleteState(
          isRedList: isRedList, isDelete: isDelete, taskList: taskList));
    });

    on<TaskDeleteSave>((event, emit) {
      isDeleteList.sort(
        (a, b) => b.compareTo(a),
      );
      for (int i in isDeleteList) {
        taskList.removeAt(i);
      }
      changedToNewList(taskList);
      saveTask(
          todoData: todoData,
          keyValue: keyValue,
          titleTask: titleTask,
          taskListNew: [...taskList]);
      emit(TaskSaveState(taskList: taskList));
    });
  }
}
