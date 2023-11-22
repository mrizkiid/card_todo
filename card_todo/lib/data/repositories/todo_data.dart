import 'package:card_todo/data/model/modelTodo.dart';
import 'package:card_todo/UTILS/static/hive_const.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoData {
  late Box _todoBox;
  // List<TitleList> listTitle = [];
  List<TaskList> listTask = [];
  // String lastKey = '';

  // Future<void> init() async {
  //   // get the box
  //   _todoBox = Hive.box(HiveKey.todoBox);
  //   // if box has been open before
  //   if (_todoBox.isOpen) {
  //     if (_todoBox.isNotEmpty) {
  //       List<dynamic> list = await _todoBox.get(HiveKey.listTitle);
  //       listTitle = list.cast<TitleList>();
  //       return;
  //     }
  //   }

  //   // if _todobox has not open
  //   if (_todoBox.isOpen == false) {
  //     Hive.registerAdapter(TitleListAdapter());
  //     Hive.registerAdapter(TodoListAdapter());
  //     Hive.registerAdapter(TaskListAdapter());
  //     //open the box
  //     _todoBox = await Hive.openBox(HiveKey.todoBox);
  //   }

  //   // checking if _todobox open and not fill yet
  //   if (_todoBox.isOpen && _todoBox.isEmpty) {
  //     // _todoBox.put(key, value)
  //     await _todoBox.put(
  //       HiveKey.listTitle,
  //       <TitleList>[
  //         TitleList(
  //             title: 'Example', keyValue: 't1', sumTask: 2, username: 'guest'),
  //       ],
  //     );
  //     await _todoBox.put(HiveKey.lastKey, 't1');
  //     await _todoBox.put(
  //       't1',
  //       TodoList(
  //         title: 'Example',
  //         taskList: <TaskList>[
  //           TaskList(isChecked: false, title: 'first task'),
  //           TaskList(isChecked: true, title: 'second task'),
  //         ],
  //       ),
  //     );
  //   }
  // }

  // List<TaskList> trueListTask() =>
  //     listTask.where((element) => element.isChecked == true).toList();

  // Future<List<TitleList>> getTitleList() async {
  //   List list = await _todoBox.get(HiveKey.listTitle);
  //   List<TitleList> titleList = list.cast<TitleList>();
  //   return titleList;
  // }

  // Future<void> saveTitleList(List<TitleList> titleList) async {
  //   await _todoBox.put(HiveKey.listTitle, titleList);
  // }

  // Future<void> addSumTask(int index, int sumTask) async {
  //   List listNew = await _todoBox.get(HiveKey.listTitle);
  //   List<TitleList> listTitleNew = listNew.cast<TitleList>();
  //   TitleList titleList = listTitleNew[index];
  //   listTitleNew[index] = TitleList(
  //       title: titleList.title,
  //       keyValue: titleList.keyValue,
  //       sumTask: sumTask,
  //       username: titleList.username);
  //   await _todoBox.put(HiveKey.listTitle, listTitleNew);
  // }

  // Future<List<TaskList>> getTaskList({required String keyValue}) async {
  //   TodoList todoList;

  //   todoList = await _todoBox.get(keyValue);
  //   return todoList.taskList;
  // }

  // Future<void> deleteTaskList({required String keyValue}) async {
  //   _todoBox.delete(keyValue);
  // }

  // Future<void> saveTaskList(
  //     {required String keyValue,
  //     required String title,
  //     required List<TaskList> taskList}) async {
  //   await _todoBox.put(keyValue, TodoList(title: title, taskList: taskList));
  // }

  // Future<String> findLastKey() async {
  //   String lastKey = _todoBox.get(HiveKey.lastKey);
  //   return lastKey;
  // }

  Future<void> saveLastKey(String keyValue) async {
    await _todoBox.put(HiveKey.lastKey, keyValue);
  }
}
