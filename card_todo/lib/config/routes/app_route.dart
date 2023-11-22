import 'package:card_todo/utils/widget/button_floating_action/bloc_button/button_animation_bloc.dart';
import 'package:card_todo/app/auth/pages/page_sign_in.dart';
import 'package:card_todo/data/model/model_arguments.dart';
import 'package:card_todo/data/model/model_user.dart';
import 'package:card_todo/app/todo/main_menu/page_main_menu.dart';
import 'package:card_todo/app/todo/task_list/bloc_task/task_menu_bloc.dart';
import 'package:card_todo/app/todo/task_list/page_task.dart';
import 'package:card_todo/utils/static/app_route_const.dart';
import 'package:card_todo/core/enums/enum_todo.dart';
import 'package:card_todo/domain/repositories/todo_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  Route onGenerateRoute({
    required RouteSettings settings,
    required TodoRepository todoRepo,
    required UserModel userModel,
  }) {
    switch (settings.name) {
      case AppRouteConst.login:
        return MaterialPageRoute(
          builder: (_) => const SingInPage(),
        );

      // case AppRouteConst.homepage:
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ButtonAnimationBloc>(
            create: (context) =>
                ButtonAnimationBloc(whichTodoBloc: WhichTodoBloc.mainMenu),
            child: const MainMenuPage(),
          ),
        );

      case AppRouteConst.taskPage:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<TaskMenuBloc>(
                create: (_) => TaskMenuBloc(
                  todoRepo: todoRepo,
                )..add(
                    TaskInitialList(
                        title: args.title,
                        keyValue: args.keyValue,
                        index: args.index),
                  ),
              ),
              BlocProvider<ButtonAnimationBloc>(
                create: (context) =>
                    ButtonAnimationBloc(whichTodoBloc: WhichTodoBloc.taskMenu),
              )
            ],
            child: TaskPage(titleTask: args.title, keyValue: args.keyValue),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const MainMenuPage(),
        );
    }
  }
}
