// ignore_for_file: prefer_const_constructors

import 'package:card_todo/DATA/model/modelTodo.dart';
import 'package:card_todo/DATA/model/model_user.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/TODO/main_menu/main_menu_bloc/mainmenu_bloc.dart';
import 'package:card_todo/UTILS/route/app_route.dart';
import 'package:card_todo/general_bloc_observer.dart';
import 'package:card_todo/repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'UTILS/static/hive_const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TitleListAdapter());
  Hive.registerAdapter(TodoListAdapter());
  Hive.registerAdapter(TaskListAdapter());
  //open the box
  await Hive.openBox(HiveKey.todoBox);

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepoProvide().init(Apps());
  }
}

class Apps extends StatefulWidget {
  const Apps({super.key});

  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  AppRoute appRoute = AppRoute();

  @override
  Widget build(BuildContext context) {
    var todoData = RepositoryProvider.of<TodoData>(context);
    var userModel = RepositoryProvider.of<UserModel>(context);
    return BlocProvider<MainMenuBloc>(
      create: (_) => MainMenuBloc(
        todoData: todoData,
        userModel: userModel,
      )..add(InitialService()),
      child: MaterialApp(
        onGenerateRoute: (settings) {
          return appRoute.onGenerateRoute(
              settings: settings, todoData: todoData, userModel: userModel);
        },
      ),
    );
  }
}
