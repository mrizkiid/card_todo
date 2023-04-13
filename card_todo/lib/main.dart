// ignore_for_file: prefer_const_constructors

import 'package:card_todo/DATA/model/modelTodo.dart';
import 'package:card_todo/DATA/model/model_user.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/UTILS/route/app_route.dart';
import 'package:card_todo/UTILS/static/enum_todo.dart';
import 'package:card_todo/general_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'UTILS/static/hive_const.dart';
import 'TODO/bloc_button/button_animation_bloc.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => UserModel(),
        ),
        RepositoryProvider(
          /// it will open the box
          create: (_) => TodoData(),
        )
      ],
      child: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AppRoute appRoute = AppRoute();
  ButtonAnimationBloc blocButtonMain =
      ButtonAnimationBloc(whichTodoBloc: WhichTodoBloc.mainMenu);

  ButtonAnimationBloc blocButtonTask =
      ButtonAnimationBloc(whichTodoBloc: WhichTodoBloc.taskMenu);

  @override
  void dispose() {
    blocButtonMain.close();
    blocButtonTask.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TodoData todoData = RepositoryProvider.of<TodoData>(context);
    UserModel userModel = RepositoryProvider.of<UserModel>(context);
    return MaterialApp(
      onGenerateRoute: (settings) {
        return appRoute.onGenerateRoute(
            settings: settings,
            todoData: todoData,
            userModel: userModel,
            blocButtonMain: blocButtonMain,
            blocButtonTask: blocButtonTask);
      },
    );
  }
}
