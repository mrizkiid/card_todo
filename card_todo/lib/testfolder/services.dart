import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import './hive/model/user.dart';
import './hive/modelketiga/modelketiga.dart';

class RepoData {
  late Box<User> _tasks;
  late User _user;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ListTaskAdapter());
    Hive.registerAdapter(ListTitleAdapter());
    _tasks = await Hive.openBox('testBox');
  }

  void initUser(String userId) {
    _user = _tasks.values.firstWhere((user) => user.userId == userId);
  }

  // void

  void addTodo(
    String userId,
    List<ListTitle> listTtile,
  ) {
    _tasks.add(
      User(
        userId: '123',
        listTask: [
          ListTitle(
            title: 'today',
            listTitle: [
              ListTask(isChecked: false, title: 'Pertama'),
              ListTask(isChecked: false, title: 'Kedua'),
            ], // list from listTitle
          ),
          ListTitle(
            title: 'Gym',
            listTitle: [
              ListTask(isChecked: false, title: 'Pertama'),
              ListTask(isChecked: false, title: 'Kedua'),
            ], // list from listTitle
          ),
        ], // list from listTask
      ),
    );
  }

  List<String> getTitle(String title) {
    List<String> titles;
    // final user = initUser(userId);
    titles = _user.listTask.map((e) => e.title).toList();
    // final titles = user.listTask.firstWhere((element) => element.title == title);
    return titles;
  }

  List<ListTask> getTasks(String title) {
    // final listTask = _user.listTask.
    final listTasks =
        _user.listTask.firstWhere((element) => element.title == title);
    final tasks = listTasks.listTitle;
    return tasks;
  }
}
