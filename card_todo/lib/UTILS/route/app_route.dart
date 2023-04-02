import 'package:card_todo/AUTH/pages/page_sign_in.dart';
import 'package:card_todo/DATA/model/modelArguments.dart';
import 'package:card_todo/DATA/model/modelUser.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/TODO/add_main_menu/page_add_main_menu.dart';
import 'package:card_todo/TODO/bloc_button/button_animation_bloc.dart';
import 'package:card_todo/TODO/main_menu/main_menu_bloc/mainmenu_bloc.dart';
import 'package:card_todo/TODO/main_menu/page_main_menu.dart';
import 'package:card_todo/TODO/task_list/bloc_task/task_menu_bloc.dart';
import 'package:card_todo/TODO/task_list/page_task.dart';
import 'package:card_todo/UTILS/static/enum_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  Route onGenerateRoute(
      RouteSettings settings, TodoData todoData, UserModel userModel) {
    switch (settings.name) {
      case '/a':
        return MaterialPageRoute(
          builder: (_) => const SingInPage(),
        );

      case '/HomePage':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    MainMenuBloc(todoData: todoData, userModel: userModel)
                      ..add(InitialService()),
              ),
              BlocProvider(
                create: (_) =>
                    ButtonAnimationBloc(whichTodoBloc: WhichTodoBloc.mainMenu),
              )
            ],
            child: const MainMenuPage(),
          ),
        );

      case '/TaskPage':
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => TaskMenuBloc(todoData: todoData)
                  ..add(
                    TaskInitialList(title: args.title, keyValue: args.keyValue),
                  ),
              ),
              BlocProvider(
                create: (_) =>
                    ButtonAnimationBloc(whichTodoBloc: WhichTodoBloc.taskMenu),
              )
            ],
            child: TaskPage(titleTask: args.title),
          ),
        );
      case '/addmainmenu':
        return MaterialPageRoute(
          builder: (_) => PageAddMainMenu(),
        );
      default:
        print('default trigerred');
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                MainMenuBloc(todoData: todoData, userModel: userModel)
                  ..add(InitialService()),
            child: const MainMenuPage(),
          ),
        );
    }
  }
}
