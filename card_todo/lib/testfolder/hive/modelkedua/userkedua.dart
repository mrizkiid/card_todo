import 'package:hive_flutter/hive_flutter.dart';
part 'userkedua.g.dart';

@HiveType(typeId: 3)
class UserKedua extends HiveObject {
  @HiveField(0)
  String userId;

  @HiveField(1)
  List<String> listTitle;

  UserKedua({required this.userId, required this.listTitle});
}

@HiveType(typeId: 4)
class ListTaskKedua extends HiveObject {
  @HiveField(0)
  String listTitle;

  @HiveField(1)
  List<ListTask> listTask;

  ListTaskKedua({required this.listTitle, required this.listTask});
}

@HiveType(typeId: 5)
class ListTask extends HiveObject {
  @HiveField(0)
  String tasks;

  @HiveField(1)
  bool checked;

  ListTask({required this.tasks, required this.checked});
}
