import 'package:card_todo/core/error/failures.dart';
import 'package:card_todo/core/responses/data_state.dart';
import 'package:card_todo/data/data_sources/local/todo_data_local_source.dart';
import 'package:card_todo/data/model/modelTodo.dart';
import 'package:card_todo/domain/repositories/todo_repo.dart';

class TodoRepoImpl extends TodoRepository {
  final TodoDataLocalSource _todoDataLocalSource;
  TodoRepoImpl(this._todoDataLocalSource);

  @override
  Future<DataState<Failure, void>> init() async {
    return await _todoDataLocalSource.init();
  }

  @override
  Future<DataState<Failure, void>> addSumTask(int index, int sumTask) async {
    return await _todoDataLocalSource.addSumTask(index, sumTask);
  }

  @override
  Future<DataState<Failure, void>> deleteTaskList(
      {required String keyValue}) async {
    return await _todoDataLocalSource.deleteTaskList(keyValue: keyValue);
  }

  @override
  Future<DataState<Failure, String>> findLastKey() async {
    return await _todoDataLocalSource.findLastKey();
  }

  @override
  Future<DataState<Failure, List<TaskList>>> getTaskList(
      {required String keyValue}) async {
    return await _todoDataLocalSource.getTaskList(keyValue: keyValue);
  }

  @override
  Future<DataState<Failure, List<TitleList>>> getTitleList() async {
    return await _todoDataLocalSource.getTitleList();
  }

  @override
  Future<DataState<Failure, void>> saveLastKey(String keyValue) async {
    return await _todoDataLocalSource.saveLastKey(keyValue);
  }

  @override
  Future<DataState<Failure, void>> saveTaskList(
      {required String keyValue,
      required String title,
      required List<TaskList> taskList}) async {
    return await _todoDataLocalSource.saveTaskList(
        keyValue: keyValue, title: title, taskList: taskList);
  }

  @override
  Future<DataState<Failure, void>> saveTitleList(
      List<TitleList> titleList) async {
    return await _todoDataLocalSource.saveTitleList(titleList);
  }

  @override
  List<DataState<Failure, TaskList>> trueListTask() {
    throw UnimplementedError();
  }
}
