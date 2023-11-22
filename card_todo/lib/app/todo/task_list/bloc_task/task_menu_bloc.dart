import 'package:bloc/bloc.dart';
import 'package:card_todo/utils/widget/button_floating_action/bloc_button/button_animation_bloc.dart';
import 'package:card_todo/core/error/failures.dart';
import 'package:card_todo/core/responses/data_state.dart';
import 'package:card_todo/data/model/modelTodo.dart';
import 'package:card_todo/domain/repositories/todo_repo.dart';
import 'package:equatable/equatable.dart';

part 'task_menu_event.dart';
part 'task_menu_state.dart';

class TaskMenuBloc extends Bloc<TaskMenuEvent, TaskMenuState> {
  late List<TaskList> _taskList;
  List<int> _indexDelete = [];
  String _keyValue = '';
  int _index = 0;
  int _sumTask = 0;
  String _titleTask = '';
  late ButtonAnimationBloc _buttonAnimationBloc;
  bool _isButtonCalled = true;
  late TodoRepository _todoRepo;

  void deleteCancel() {
    _indexDelete = [];
  }

  void initBloc(ButtonAnimationBloc input) {
    _buttonAnimationBloc = input;
  }

  void emptyOrNotEmptyList() {
    if (_taskList.isEmpty && _isButtonCalled == true) {
      _isButtonCalled = false;
      _buttonAnimationBloc.add(ButtonEmptyEvent());
    }
    if (_taskList.isNotEmpty && _isButtonCalled == false) {
      _isButtonCalled = true;
      _buttonAnimationBloc.add(ButtonActionAdd());
    }
  }

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

  Future<DataState<Failure, void>> saveTask(
      {
      // required TodoData todoData,
      required String keyValue,
      required String titleTask,
      required List<TaskList> taskListNew}) async {
    // todoData.listTask = taskListNew;
    final dataState = await _todoRepo.saveTaskList(
        keyValue: keyValue, title: titleTask, taskList: taskListNew);
    return dataState;
  }

  TaskMenuBloc({required TodoRepository todoRepo})
      : super(const TaskMenuInitial(taskList: [], sumTask: 0)) {
    _todoRepo = todoRepo;

    on<TaskInitialList>((event, emit) async {
      _keyValue = event.keyValue ?? _keyValue;
      _titleTask = event.title ?? _titleTask;
      if (event.index != null) {
        _index = event.index!;
      }
      final dataState = await _todoRepo.getTaskList(keyValue: _keyValue);
      dataState.run(
        success: (data) => {
          if (data != null) {_taskList = data}
        },
        error: (failure) {
          emit(TaskFailedState(
              taskList: state.taskList, sumTask: state.sumTask));
          return;
        },
      );
      _taskList = orderList(taskList: _taskList);
      // todoData.listTask = [..._taskList];
      final listFalse = findTaskListFalse(taskList: [..._taskList]);
      _sumTask = listFalse.length;

      // add event buttonAnimation
      emptyOrNotEmptyList();

      emit(TaskState(taskList: _taskList, sumTask: _sumTask));
    });

    on<TaskEvent>((event, emit) async {
      bool isChecked = !event.isChecked;
      changedToNewList(state.taskList);
      _taskList[event.index] =
          TaskList(isChecked: isChecked, title: event.title);
      _taskList = orderList(taskList: _taskList);
      final listFalse = findTaskListFalse(taskList: _taskList);
      _sumTask = listFalse.length;
      // add sumtask
      final dataState = await _todoRepo.addSumTask(_index, _sumTask);
      dataState.run(
        success: (data) => {},
        error: (failure) {
          emit(TaskFailedState(
              taskList: state.taskList, sumTask: state.sumTask));
          return;
        },
      );
      final dataStateSaveTask = await saveTask(
          // todoData: todoData,
          keyValue: _keyValue,
          titleTask: _titleTask,
          taskListNew: [..._taskList]);

      dataStateSaveTask.run(
        success: (data) =>
            emit(TaskState(taskList: _taskList, sumTask: _sumTask)),
        error: (failure) {
          emit(TaskFailedState(
              taskList: state.taskList, sumTask: state.sumTask));
          return;
        },
      );
    });

    //taskAdd
    on<TaskAddEvent>((event, emit) async {
      _taskList = state.taskList;
      _taskList.add(TaskList(isChecked: false, title: event.task));
      _taskList = orderList(taskList: _taskList);
      changedToNewList(_taskList);
      final listFalse = findTaskListFalse(taskList: _taskList);
      _sumTask = listFalse.length;

      // add event buttonAnimation
      emptyOrNotEmptyList();

      final dataState = await _todoRepo.addSumTask(_index, _sumTask);
      dataState.run(
        success: (data) => {},
        error: (failure) {
          emit(TaskFailedState(
              taskList: state.taskList, sumTask: state.sumTask));
          return;
        },
      );
      final datatStateSaveTask = await saveTask(
          // todoData: todoData,
          keyValue: _keyValue,
          titleTask: event.task,
          taskListNew: _taskList);
      datatStateSaveTask.run(
        success: (data) =>
            emit(TaskSaveState(taskList: _taskList, sumTask: _sumTask)),
        error: (failure) {
          emit(TaskFailedState(
              taskList: state.taskList, sumTask: state.sumTask));
          return;
        },
      );
    });

    /// Task Reordered
    on<TaskReordered>((event, emit) {
      bool isOrdered = event.isOrdered;
      _taskList = [...state.taskList];
      List<TaskList> taskListFalse =
          findTaskListFalse(taskList: state.taskList);
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
      // _sumTask = _taskList.length;
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
            // todoData: todoData,
            keyValue: _keyValue,
            titleTask: _titleTask,
            taskListNew: [..._taskList]);
      }
      changedToNewList(_taskList);
      emit(TaskSaveState(taskList: _taskList, sumTask: _sumTask));
    });

    /// Task Delete
    on<TaskDelete>((event, emit) {
      bool isDelete = event.isDelete;
      _taskList = [...state.taskList];
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

      _indexDelete.add(index);

      changedToNewList(state.taskList);
      emit(TaskDeleteState(
          isRedList: isRedList,
          isDelete: isDelete,
          taskList: _taskList,
          sumTask: _sumTask));
    });

    on<TaskDeleteSave>((event, emit) async {
      _indexDelete.sort(
        (a, b) => b.compareTo(a),
      );
      for (int i in _indexDelete) {
        _taskList.removeAt(i);
      }
      changedToNewList(_taskList);
      final listFalse = findTaskListFalse(taskList: _taskList);
      _sumTask = listFalse.length;
      final dataState = await _todoRepo.addSumTask(_index, _sumTask);
      dataState.run(
        success: (data) => {},
        error: (failure) {
          emit(TaskFailedState(
              taskList: state.taskList, sumTask: state.sumTask));
          return;
        },
      );
      final dataStateSaveTask = await saveTask(
          // todoData: todoData,
          keyValue: _keyValue,
          titleTask: _titleTask,
          taskListNew: [..._taskList]);
      dataStateSaveTask.run(
        success: (data) => {},
        error: (failure) {
          emit(TaskFailedState(
              taskList: state.taskList, sumTask: state.sumTask));
          return;
        },
      );

      // add event buttonAnimation
      emptyOrNotEmptyList();

      emit(TaskSaveState(taskList: _taskList, sumTask: _sumTask));

      // make isDeleteList 0
      _indexDelete = [];
    });
  }
}
