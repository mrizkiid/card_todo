// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:card_todo/DATA/model/modelTodo.dart';
import 'package:card_todo/testfolder/hive/model/user.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoData {
  late Box _todoBox;
  List<TitleList> listTitle = [];

  Future<void> init() async {
    Hive.registerAdapter(TitleListAdapter());
    _todoBox = await Hive.openBox('todobox');
    if (_todoBox.isEmpty) {
      // _todoBox.put(key, value)
      _todoBox.put(
        'ListTitle',
        [
          TitleList(title: 'Example', keyValue: 't1', sumTask: 2),
        ],
      );
      _todoBox.put(
        't1',
        TodoList(
          title: 'Example',
          taskList: [
            TaskList(isChecked: false, title: 'first task'),
            TaskList(isChecked: true, title: 'second task'),
          ],
        ),
      );
      _todoBox.put('LastKey', 't1');
    }
    if (_todoBox.isNotEmpty) {
      listTitle = _todoBox.get('ListTitle');
    }
  }

  Future<List<TitleList>> get getTitleList async =>
      await _todoBox.get('ListTitle');

  void saveTitleList(List<TitleList> titleList) async {
    await _todoBox.put('ListTitle', titleList);
  }

  // void editTitleList(Str)

  Future<List<TaskList>> getTaskList(String title, String keyValue) async {
    TodoList todoList;

    todoList = await _todoBox.get(keyValue);
    return todoList.taskList;
  }

  Future<void> saveTaskList(
      {required String keyValue,
      required String title,
      required List<TaskList> taskList}) async {
    await _todoBox.put(keyValue, TodoList(title: title, taskList: taskList));
  }

  Future<String> get findLastKey async {
    String lastKey = _todoBox.get('LastKey');
    return lastKey;
  }

  // List<String> listTask = [
  //   'todo1',
  //   'todo2',
  //   'todo3',
  //   'todo4',
  //   'todo5',
  //   'todo6',
  //   'todo7',
  //   'todo8',
  //   'todo9',
  //   'todo10',
  // ];
  // List<String> listTitle = [
  //   'GYM',
  //   'PRAY',
  //   'DIET',
  //   'WORK',
  //   'THESIS',
  //   'RELATIONSHIP'
  // ];
  // // List<String> listTitle = [
  // //   'GYM',
  // //   'PRAY',
  // //   'DIET',
  // //   'WORK',
  // //   'THESIS',
  // //   'PROJECT1',
  // //   'RELATIONSHIP',
  // //   'PROJECT2',
  // //   'PROJECT4',
  // //   'PROJECT3',
  // //   'PROJECT5',
  // //   'PROJECT6',
  // //   'PROJECT7',
  // // ];

  // List<TodoList> todoList = [
  //   TodoList(
  //     title: 'Gym',
  //     taskList: [
  //       TaskList(isChecked: false, title: 'Gym Pertama'),
  //       TaskList(isChecked: true, title: 'Gym Kedua'),
  //       TaskList(isChecked: false, title: 'Gym Ketiga'),
  //       TaskList(isChecked: false, title: 'Gym Keempat'),
  //       TaskList(isChecked: true, title: 'Gym Kelima'),
  //       TaskList(isChecked: true, title: 'Gym Keenam'),
  //       TaskList(isChecked: false, title: 'Gym Ketujuh'),
  //     ],
  //   ),
  //   TodoList(
  //     title: 'Pray',
  //     taskList: [
  //       TaskList(isChecked: false, title: 'Pray Pertama'),
  //       TaskList(isChecked: true, title: 'Pray Kedua'),
  //       TaskList(isChecked: false, title: 'Pray Ketiga'),
  //       TaskList(isChecked: false, title: 'Pray Keempat'),
  //       TaskList(isChecked: true, title: 'Pray Kelima'),
  //       TaskList(isChecked: true, title: 'Pray Keenam'),
  //       TaskList(isChecked: false, title: 'Pray Ketujuh'),
  //     ],
  //   ),
  //   TodoList(
  //     title: 'Diet',
  //     taskList: [
  //       TaskList(isChecked: false, title: 'Diet Pertama'),
  //       TaskList(isChecked: true, title: 'Diet Kedua'),
  //       TaskList(isChecked: false, title: 'Diet Ketiga'),
  //       TaskList(isChecked: false, title: 'Diet Keempat'),
  //       TaskList(isChecked: true, title: 'Diet Kelima'),
  //       TaskList(isChecked: true, title: 'Diet Keenam'),
  //       TaskList(isChecked: false, title: 'Diet Ketujuh'),
  //     ],
  //   ),
  //   TodoList(
  //     title: 'Work',
  //     taskList: [
  //       TaskList(isChecked: false, title: 'Work Pertama'),
  //       TaskList(isChecked: true, title: 'Work Kedua'),
  //       TaskList(isChecked: false, title: 'Work Ketiga'),
  //       TaskList(isChecked: false, title: 'Work Keempat'),
  //       TaskList(isChecked: true, title: 'Work Kelima'),
  //       TaskList(isChecked: true, title: 'Work Keenam'),
  //       TaskList(isChecked: false, title: 'Work Ketujuh'),
  //     ],
  //   ),
  //   TodoList(
  //     title: 'Thesis',
  //     taskList: [
  //       TaskList(isChecked: false, title: 'Thesis Pertama'),
  //       TaskList(isChecked: true, title: 'Thesis Kedua'),
  //       TaskList(isChecked: false, title: 'Thesis Ketiga'),
  //       TaskList(isChecked: false, title: 'Thesis Keempat'),
  //       TaskList(isChecked: true, title: 'Thesis Kelima'),
  //       TaskList(isChecked: true, title: 'Thesis Keenam'),
  //       TaskList(isChecked: false, title: 'Thesis Ketujuh'),
  //     ],
  //   ),
  //   TodoList(
  //     title: 'Relationship',
  //     taskList: [
  //       TaskList(isChecked: false, title: 'Relationship Pertama'),
  //       TaskList(isChecked: true, title: 'Relationship Kedua'),
  //       TaskList(isChecked: false, title: 'Relationship Ketiga'),
  //       TaskList(isChecked: false, title: 'Relationship Keempat'),
  //       TaskList(isChecked: true, title: 'Relationship Kelima'),
  //       TaskList(isChecked: true, title: 'Relationship Keenam'),
  //       TaskList(isChecked: false, title: 'Relationship Ketujuh'),
  //     ],
  //   ),
  // ];

  // // List<String> getTi

  // void updateTask(
  //     String keyValue, String title, List<TaskList> listTask) async {
  //   // final taskForEdit =
  // }

  // List<String> get getTitleList => todoList.map((e) => e.title).toList();

  // List<TaskList> getTasklist(String title) =>
  //     todoList.firstWhere((element) => element.title == title).taskList;

  // List<TaskList> tasklist = [
  //   TaskList(isChecked: false, title: 'Pertama'),
  //   TaskList(isChecked: true, title: 'Kedua'),
  //   TaskList(isChecked: false, title: 'Ketiga'),
  //   TaskList(isChecked: false, title: 'Keempat'),
  //   TaskList(isChecked: true, title: 'Kelima'),
  //   TaskList(isChecked: true, title: 'Keenam'),
  //   TaskList(isChecked: false, title: 'Ketujuh'),
  // ];

  // void orderList() {}
}

// class TaskList {
//   final bool isChecked;
//   final String title;
//   TaskList({
//     required this.isChecked,
//     required this.title,
//   });
// }

// class TodoList {
//   final String title;
//   final List<TaskList> taskList;
//   TodoList({
//     required this.title,
//     required this.taskList,
//   });
// }

// class TitleList {
//   final String title;
//   final String keyValue;

//   TitleList({required this.title, required this.keyValue});
// }
