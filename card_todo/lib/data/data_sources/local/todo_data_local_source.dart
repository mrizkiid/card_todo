import 'package:card_todo/UTILS/static/hive_const.dart';
import 'package:card_todo/core/error/failures.dart';
import 'package:card_todo/core/responses/data_state.dart';
import 'package:card_todo/data/model/modelTodo.dart';
import 'package:card_todo/domain/repositories/todo_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class TodoDataLocalSource extends TodoRepository {}

class TodoDataLocalSourceImpl implements TodoDataLocalSource {
  late Box _todoBox;

  @override
  Future<DataState<Failure, void>> init() async {
    try {
      // get the box
      _todoBox = Hive.box(HiveKey.todoBox);

      // if _todobox has not open
      if (_todoBox.isOpen == false) {
        Hive.registerAdapter(TitleListAdapter());
        Hive.registerAdapter(TodoListAdapter());
        Hive.registerAdapter(TaskListAdapter());
        //open the box
        _todoBox = await Hive.openBox(HiveKey.todoBox);
      }

      // checking if _todobox open and not fill yet
      if (_todoBox.isOpen && _todoBox.isEmpty) {
        // _todoBox.put(key, value)
        await _todoBox.put(
          HiveKey.listTitle,
          <TitleList>[
            TitleList(
                title: 'Example',
                keyValue: 't1',
                sumTask: 2,
                username: 'guest'),
          ],
        );
        await _todoBox.put(HiveKey.lastKey, 't1');
        await _todoBox.put(
          't1',
          TodoList(
            title: 'Example',
            taskList: <TaskList>[
              TaskList(isChecked: false, title: 'first task'),
              TaskList(isChecked: true, title: 'second task'),
            ],
          ),
        );
      }
      return DataSuccess();
    } catch (e) {
      return DataFailed(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataState<Failure, void>> addSumTask(int index, int sumTask) async {
    try {
      List listNew = await _todoBox.get(HiveKey.listTitle);
      List<TitleList> listTitleNew = listNew.cast<TitleList>();
      TitleList titleList = listTitleNew[index];
      listTitleNew[index] = TitleList(
          title: titleList.title,
          keyValue: titleList.keyValue,
          sumTask: sumTask,
          username: titleList.username);
      await _todoBox.put(HiveKey.listTitle, listTitleNew);
      return DataSuccess();
    } catch (e) {
      return DataFailed(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataState<Failure, void>> deleteTaskList(
      {required String keyValue}) async {
    try {
      await _todoBox.delete(keyValue);
      return DataSuccess();
    } catch (e) {
      return DataFailed(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataState<Failure, String>> findLastKey() async {
    try {
      String lastKey = await _todoBox.get(HiveKey.lastKey);
      return DataSuccess(lastKey);
    } catch (e) {
      return DataFailed(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataState<Failure, List<TaskList>>> getTaskList(
      {required String keyValue}) async {
    try {
      TodoList todoList = await _todoBox.get(keyValue);
      return DataSuccess(todoList.taskList);
    } catch (e) {
      return DataFailed(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataState<Failure, List<TitleList>>> getTitleList() async {
    try {
      List list = await _todoBox.get(HiveKey.listTitle);
      List<TitleList> titleList = list.cast<TitleList>();
      return DataSuccess(titleList);
    } catch (e) {
      return DataFailed(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataState<Failure, void>> saveLastKey(String keyValue) async {
    try {
      await _todoBox.put(HiveKey.lastKey, keyValue);
      return DataSuccess();
    } catch (e) {
      return DataFailed(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataState<Failure, void>> saveTaskList(
      {required String keyValue,
      required String title,
      required List<TaskList> taskList}) async {
    try {
      await _todoBox.put(keyValue, TodoList(title: title, taskList: taskList));
      return DataSuccess();
    } catch (e) {
      return DataFailed(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataState<Failure, void>> saveTitleList(
      List<TitleList> titleList) async {
    try {
      await _todoBox.put(HiveKey.listTitle, titleList);
      return DataSuccess();
    } catch (e) {
      return DataFailed(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  List<DataState<Failure, TaskList>> trueListTask() {
    throw UnimplementedError();
  }
}
