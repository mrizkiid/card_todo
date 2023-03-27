import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/TODO/bloc_button/button_animation_bloc.dart';
import 'package:card_todo/TODO/main_menu/main_menu_bloc/mainmenu_bloc.dart';
import 'package:card_todo/TODO/main_menu/page_main_menu.dart';
import 'package:card_todo/TODO/task_list/bloc_task/task_menu_bloc.dart';
import 'package:card_todo/TODO/task_list/page_task.dart';
import 'package:card_todo/UTILS/static/enum_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings settings, TodoData todoData) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => MainMenuBloc(todoData: todoData),
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
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => TaskMenuBloc(todoData: todoData),
              ),
              BlocProvider(
                create: (_) =>
                    ButtonAnimationBloc(whichTodoBloc: WhichTodoBloc.taskMenu),
              )
            ],
            child: const TaskPage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => MainMenuBloc(todoData: todoData),
          ),
        );
    }
  }
}
