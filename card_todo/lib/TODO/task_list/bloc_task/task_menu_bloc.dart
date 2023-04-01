import 'package:bloc/bloc.dart';
import 'package:card_todo/DATA/model/modelTodo.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:equatable/equatable.dart';

part 'task_menu_event.dart';
part 'task_menu_state.dart';

class TaskMenuBloc extends Bloc<TaskMenuEvent, TaskMenuState> {
  late List<TaskList> _taskList;
  late List<int> _isDeleteList;
  String _keyValue = '';
  String _titleTask = '';

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
    _taskList = [...taskListNew];
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
      _keyValue = event.keyValue ?? _keyValue;
      _titleTask = event.title ?? _keyValue;
      _taskList = [
        ...await todoData.getTaskList(title: _titleTask, keyValue: _keyValue)
      ];
      _taskList = orderList(taskList: state.taskList);
      todoData.listTask = [..._taskList];
      emit(TaskState(taskList: _taskList));
    });

    on<TaskEvent>((event, emit) {
      bool isChecked = !event.isChecked;
      _taskList = [...state.taskList];
      _taskList[event.index] =
          TaskList(isChecked: isChecked, title: event.title);
      _taskList = orderList(taskList: _taskList);
      // todoData.saveTaskList(
      //     keyValue: keyValue, title: titleTask, taskList: [...taskList]);
      saveTask(
          todoData: todoData,
          keyValue: _keyValue,
          titleTask: _titleTask,
          taskListNew: [..._taskList]);
      emit(TaskState(taskList: _taskList));
    });

    ///
    /// Task Reordered
    ///
    on<TaskReordered>((event, emit) {
      bool isOrdered = event.isOrdered;
      _taskList = [...state.taskList];
      List<TaskList> taskListFalse =
          findTaskListFalse(taskList: state.taskList);
      emit(TaskReorderState(
          taskList: _taskList,
          taskListFalse: taskListFalse,
          isOrdered: isOrdered));
    });

    on<TaskReorderedProcess>((event, emit) {
      _taskList = [...state.taskList];
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
          taskList: _taskList, taskListFalse: taskListFalse, isOrdered: true));
    });

    on<TaskReorderSave>((event, emit) {
      if (state is TaskReorderState) {
        final currentState = state as TaskReorderState;
        _taskList = [
          ...currentState.taskListFalse,
          ...findTaskListTrue(taskList: state.taskList)
        ];
        saveTask(
            todoData: todoData,
            keyValue: _keyValue,
            titleTask: _titleTask,
            taskListNew: [..._taskList]);
      }
      changedToNewList(_taskList);
      emit(TaskSaveState(taskList: _taskList));
    });

    ///
    /// Task Delete
    ///
    on<TaskDelete>((event, emit) {
      bool isDelete = event.isDelete;
      _taskList = [...state.taskList];
      emit(TaskDeleteState(
          isRedList: List.filled(_taskList.length, false),
          isDelete: isDelete,
          taskList: _taskList));
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

      _isDeleteList.add(index);

      changedToNewList(state.taskList);

      emit(TaskDeleteState(
          isRedList: isRedList, isDelete: isDelete, taskList: _taskList));
    });

    on<TaskDeleteSave>((event, emit) {
      _isDeleteList.sort(
        (a, b) => b.compareTo(a),
      );
      for (int i in _isDeleteList) {
        _taskList.removeAt(i);
      }
      changedToNewList(_taskList);
      saveTask(
          todoData: todoData,
          keyValue: _keyValue,
          titleTask: _titleTask,
          taskListNew: [..._taskList]);
      emit(TaskSaveState(taskList: _taskList));
    });
  }
}
