import 'package:hive_flutter/hive_flutter.dart';

part 'modelTodo.g.dart';

@HiveType(typeId: 0)
class TitleList {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String keyValue;
  @HiveField(2)
  final int sumTask;

  TitleList(
      {required this.title, required this.keyValue, required this.sumTask});
}

@HiveType(typeId: 1)
class TodoList {
  @HiveField(0)
  final String title;
  @HiveField(1)
  List<TaskList> taskList;
  TodoList({
    required this.title,
    required this.taskList,
  });
}

@HiveType(typeId: 2)
class TaskList {
  @HiveField(0)
  final bool isChecked;
  @HiveField(1)
  final String title;
  TaskList({
    required this.isChecked,
    required this.title,
  });
}
