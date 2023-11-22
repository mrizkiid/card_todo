import 'package:card_todo/core/error/failures.dart';
import 'package:card_todo/core/responses/data_state.dart';
import 'package:card_todo/data/model/modelTodo.dart';

abstract class TodoRepository {
  Future<DataState<Failure, void>> init();
  List<DataState<Failure, TaskList>> trueListTask();
  Future<DataState<Failure, List<TitleList>>> getTitleList();
  Future<DataState<Failure, void>> saveTitleList(List<TitleList> titleList);
  Future<DataState<Failure, void>> addSumTask(int index, int sumTask);
  Future<DataState<Failure, List<TaskList>>> getTaskList(
      {required String keyValue});
  Future<DataState<Failure, void>> deleteTaskList({required String keyValue});
  Future<DataState<Failure, void>> saveTaskList(
      {required String keyValue,
      required String title,
      required List<TaskList> taskList});
  Future<DataState<Failure, String>> findLastKey();
  Future<DataState<Failure, void>> saveLastKey(String keyValue);
}
