// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:card_todo/AUTH/pages/page_sign_in.dart';
import 'package:card_todo/AUTH/pages/page_sign_up.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/TODO/add_main_menu/page_add_main_menu.dart';
import 'package:card_todo/TODO/main_menu/page_main_menu.dart';
import 'package:card_todo/TODO/task_list/page_task.dart';
import 'package:card_todo/UTILS/route/app_route.dart';
import 'package:card_todo/UTILS/static/size_class.dart';
import 'package:card_todo/general_bloc_observer.dart';
import 'package:card_todo/testfolder/testfile.dart';
import 'package:flutter/material.dart';
import './AUTH/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => TodoData(),
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  App({super.key});
  AppRoute appRoute = AppRoute();

  @override
  Widget build(BuildContext context) {
    TodoData todoData = RepositoryProvider.of<TodoData>(context);
    return MaterialApp(
      onGenerateRoute: (settings) {
        return appRoute.onGenerateRoute(
          settings,
          todoData,
        );
      },
      // home: SingInPage(),
      // home: PageSignUp(),
      // home: TestGridCardPage(),
      // home: TaskPage(),
      // home: TestPageFolder(),
      // home: MainMenuPage(),
      // home: PageAddMainMenu(),
    );
  }
}
