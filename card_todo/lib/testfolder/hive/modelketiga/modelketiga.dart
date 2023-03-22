import 'package:hive/hive.dart';
part 'modelketiga.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String userId;

  @HiveField(1)
  List<String> title;
  // List<ListTitle> listTask;

  User({required this.userId, required this.title});
}

@HiveType(typeId: 1)
class ListTitle extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  List<ListTask> listTitle;

  ListTitle({required this.title, required this.listTitle});
}

@HiveType(typeId: 2)
class ListTask extends HiveObject {
  @HiveField(0)
  bool isChecked;
  @HiveField(1)
  String title;

  ListTask({required this.isChecked, required this.title});
}
