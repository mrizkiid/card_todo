import 'package:card_todo/TODO/main_menu/main_menu_bloc/mainmenu_bloc.dart';
import 'package:card_todo/TODO/task_list/bloc_task/task_menu_bloc.dart';
import 'package:card_todo/TODO/bloc_button/button_animation_bloc.dart';
import 'package:card_todo/UTILS/static/enum_todo.dart';
import './widget_button_animation_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:card_todo/UTILS/icon/todo_app_icon_icons.dart';

const double buttonsize = 80;

// enum

class LinearFlowWidget extends StatefulWidget {
  const LinearFlowWidget({
    Key? key,
    required this.isAction,
  }) : super(key: key);

  final bool isAction;

  @override
  State<LinearFlowWidget> createState() => _LinearFlowWidgetState();
}

class _LinearFlowWidgetState extends State<LinearFlowWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  MainMenuBloc? mainMenuBloc;
  TaskMenuBloc? taskMenuBloc;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onPressedReorder(
      {required ButtonAnimationBloc buttonAnimationBloc,
      required MainMenuBloc? mainMenuBloc,
      required TaskMenuBloc? taskMenuBloc}) {
    if (buttonAnimationBloc.whichTodoBloc == WhichTodoBloc.mainMenu &&
        mainMenuBloc != null) {
      mainMenuBloc.add(MainReorderEvent(true));
    }
    if (buttonAnimationBloc.whichTodoBloc == WhichTodoBloc.taskMenu &&
        taskMenuBloc != null) {
      taskMenuBloc.add(const TaskReordered(true));
    }
  }

  void onPressedDelete(
      {required ButtonAnimationBloc buttonAnimationBloc,
      required MainMenuBloc? mainMenuBloc,
      required TaskMenuBloc? taskMenuBloc}) {
    if (buttonAnimationBloc.whichTodoBloc == WhichTodoBloc.mainMenu &&
        mainMenuBloc != null) {
      mainMenuBloc.add(const MainDeleteEvent(true));
    }
    if (buttonAnimationBloc.whichTodoBloc == WhichTodoBloc.taskMenu &&
        taskMenuBloc != null) {
      taskMenuBloc.add(const TaskDelete(true));
      print('taskdelete is called');
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonAnimationBloc = context.read<ButtonAnimationBloc>();
    if (buttonAnimationBloc.whichTodoBloc == WhichTodoBloc.mainMenu) {
      mainMenuBloc = context.read<MainMenuBloc>();
    }
    if (buttonAnimationBloc.whichTodoBloc == WhichTodoBloc.taskMenu) {
      taskMenuBloc = context.read<TaskMenuBloc>();
    }

    return Flow(delegate: FlowMenuDelegate(controller: controller), children: [
      BuildItemUtama(
          isAction: widget.isAction,
          title1: 'Action',
          title2: 'Close',
          onPressed: () {
            if (controller.isCompleted) {
              context
                  .read<ButtonAnimationBloc>()
                  .add(const ButtonActionEvent(isAction: true));
              controller.reverse();
              return;
            }
            if (controller.isAnimating) {
              return;
            }
            if (controller.isDismissed) {
              context
                  .read<ButtonAnimationBloc>()
                  .add(const ButtonActionEvent(isAction: true));
              controller.forward();
              return;
            }
          }),
      BuildItem(
          icon: Icons.add,
          title: 'Add',
          onPressed: () {
            controller.reset();
            buttonAnimationBloc.add(ButtonActionAdd());
          }),
      BuildItem(
          icon: TodoAppIcon.convert,
          title: 'Reorder',
          onPressed: () {
            controller.reset();
            buttonAnimationBloc.add(const ButtonActionReorder());
            onPressedReorder(
                buttonAnimationBloc: buttonAnimationBloc,
                mainMenuBloc: mainMenuBloc,
                taskMenuBloc: taskMenuBloc);
          }),
      BuildItem(
          icon: TodoAppIcon.delete,
          title: 'Delete',
          onPressed: () {
            controller.reset();
            buttonAnimationBloc.add(const ButtonActionDelete());
            onPressedDelete(
                buttonAnimationBloc: buttonAnimationBloc,
                mainMenuBloc: mainMenuBloc,
                taskMenuBloc: taskMenuBloc);
          }),
    ]);
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;

  const FlowMenuDelegate({required this.controller})
      : super(repaint: controller);
  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xstart = size.width - context.getChildSize(0)!.width;
    final ystart = size.height - context.getChildSize(0)!.height;

    for (var i = context.childCount - 1; i >= 0; i--) {
      int margin = 10;
      final childSize = context.getChildSize(i)!.height;
      double dx = (childSize + margin) * i;
      // margin = margin - 10;

      final x = xstart;
      final y = ystart - (dx * controller.value);
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}

class MainDialogAdd extends StatelessWidget {
  const MainDialogAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
