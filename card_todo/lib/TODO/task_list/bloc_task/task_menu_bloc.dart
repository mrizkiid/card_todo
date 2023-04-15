import 'package:bloc/bloc.dart';
import 'package:card_todo/DATA/model/modelTodo.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:equatable/equatable.dart';

part 'task_menu_event.dart';
part 'task_menu_state.dart';

class TaskMenuBloc extends Bloc<TaskMenuEvent, TaskMenuState> {
  late List<TaskList> _taskList;
  List<int> _isDeleteList = [];
  String _keyValue = '';
  int _index = 0;
  int _sumTask = 0;
  String _titleTask = '';

  void settingsKeyAndTitle({required String keyValue, required int index}) {
    _keyValue = keyValue;
    _index = index;
  }

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

  Future<void> saveTask(
      {required TodoData todoData,
      required String keyValue,
      required String titleTask,
      required List<TaskList> taskListNew}) async {
    todoData.listTask = taskListNew;
    await todoData.saveTaskList(
        keyValue: keyValue, title: titleTask, taskList: taskListNew);
  }

  TaskMenuBloc({required TodoData todoData})
      : super(const TaskMenuInitial(taskList: [], sumTask: 0)) {
    on<TaskInitialList>((event, emit) async {
      _keyValue = event.keyValue ?? _keyValue;
      _titleTask = event.title ?? _titleTask;
      if (event.index != null) {
        _index = event.index!;
      }
      _taskList = [...await todoData.getTaskList(keyValue: _keyValue)];
      _taskList = orderList(taskList: _taskList);
      todoData.listTask = [..._taskList];
      _sumTask = _taskList.length;

      emit(TaskState(taskList: _taskList, sumTask: _sumTask));
    });

    on<TaskEvent>((event, emit) async {
      bool isChecked = !event.isChecked;
      changedToNewList(state.taskList);
      _taskList[event.index] =
          TaskList(isChecked: isChecked, title: event.title);
      _taskList = orderList(taskList: _taskList);
      _sumTask = _taskList.length;
      await saveTask(
          todoData: todoData,
          keyValue: _keyValue,
          titleTask: _titleTask,
          taskListNew: [..._taskList]);
      emit(TaskState(taskList: _taskList, sumTask: _sumTask));
    });

    //taskAdd
    on<TaskAddEvent>((event, emit) async {
      _taskList = state.taskList;
      _taskList.add(TaskList(isChecked: false, title: event.task));
      _taskList = orderList(taskList: _taskList);
      changedToNewList(_taskList);
      _sumTask = _taskList.length;
      await todoData.addSumTask(_index, _sumTask);
      print('Key Value = $_keyValue ---- SumTask $_sumTask');
      await saveTask(
          todoData: todoData,
          keyValue: _keyValue,
          titleTask: event.task,
          taskListNew: _taskList);
      emit(TaskSaveState(taskList: _taskList, sumTask: _sumTask));
    });

    /// Task Reordered
    on<TaskReordered>((event, emit) {
      bool isOrdered = event.isOrdered;
      _taskList = [...state.taskList];
      List<TaskList> taskListFalse =
          findTaskListFalse(taskList: state.taskList);
      _sumTask = _taskList.length;
      emit(TaskReorderState(
          taskList: _taskList,
          taskListFalse: taskListFalse,
          isOrdered: isOrdered,
          sumTask: _sumTask));
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
      _sumTask = _taskList.length;
      emit(TaskReorderState(
          taskList: _taskList,
          taskListFalse: taskListFalse,
          isOrdered: true,
          sumTask: _sumTask));
    });

    on<TaskReorderSave>((event, emit) async {
      if (state is TaskReorderState) {
        final currentState = state as TaskReorderState;
        _taskList = [
          ...currentState.taskListFalse,
          ...findTaskListTrue(taskList: state.taskList)
        ];
        await saveTask(
            todoData: todoData,
            keyValue: _keyValue,
            titleTask: _titleTask,
            taskListNew: [..._taskList]);
      }
      changedToNewList(_taskList);
      _sumTask = _taskList.length;
      emit(TaskSaveState(taskList: _taskList, sumTask: _sumTask));
    });

    /// Task Delete
    on<TaskDelete>((event, emit) {
      bool isDelete = event.isDelete;
      _taskList = [...state.taskList];
      _sumTask = _taskList.length;
      emit(TaskDeleteState(
          isRedList: List.filled(_taskList.length, false),
          isDelete: isDelete,
          taskList: _taskList,
          sumTask: _sumTask));
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
      _sumTask = _taskList.length;
      emit(TaskDeleteState(
          isRedList: isRedList,
          isDelete: isDelete,
          taskList: _taskList,
          sumTask: _sumTask));
    });

    on<TaskDeleteSave>((event, emit) async {
      _isDeleteList.sort(
        (a, b) => b.compareTo(a),
      );
      for (int i in _isDeleteList) {
        _taskList.removeAt(i);
      }
      changedToNewList(_taskList);
      _sumTask = _taskList.length;
      await todoData.addSumTask(_index, _sumTask);
      await saveTask(
          todoData: todoData,
          keyValue: _keyValue,
          titleTask: _titleTask,
          taskListNew: [..._taskList]);
      emit(TaskSaveState(taskList: _taskList, sumTask: _sumTask));

      // make isDeleteList 0
      _isDeleteList = [];
    });

    on<TaskDeleteCancel>((event, emit) {
      _isDeleteList = [];
    });
  }
}
