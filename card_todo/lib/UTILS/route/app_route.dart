import 'package:card_todo/AUTH/pages/page_sign_in.dart';
import 'package:card_todo/DATA/model/model_arguments.dart';
import 'package:card_todo/DATA/model/model_user.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/TODO/bloc_button/button_animation_bloc.dart';
import 'package:card_todo/TODO/main_menu/main_menu_bloc/mainmenu_bloc.dart';
import 'package:card_todo/TODO/main_menu/page_main_menu.dart';
import 'package:card_todo/TODO/task_list/bloc_task/task_menu_bloc.dart';
import 'package:card_todo/TODO/task_list/page_task.dart';
import 'package:card_todo/UTILS/static/app_route_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  Route onGenerateRoute(
      {required RouteSettings settings,
      required TodoData todoData,
      required UserModel userModel,
      required ButtonAnimationBloc blocButtonMain,
      required ButtonAnimationBloc blocButtonTask}) {
    switch (settings.name) {
      case AppRouteConst.login:
        return MaterialPageRoute(
          builder: (_) => const SingInPage(),
        );

      // case AppRouteConst.homepage:
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: blocButtonMain,
            child: const MainMenuPage(),
          ),
        );

      case AppRouteConst.taskPage:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => TaskMenuBloc(
                    todoData: todoData, buttonAnimationBloc: blocButtonTask)
                  ..add(
                    TaskInitialList(title: args.title, keyValue: args.keyValue),
                  ),
              ),
              BlocProvider.value(
                value: blocButtonTask,
              )
            ],
            child: TaskPage(titleTask: args.title, keyValue: args.keyValue),
          ),
        );
      default:
        print('default trigerred');
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => MainMenuBloc(
                todoData: todoData,
                userModel: userModel,
                buttonAnimationBloc: blocButtonMain)
              ..add(InitialService()),
            child: const MainMenuPage(),
          ),
        );
    }
  }
}
