import 'package:card_todo/TODO/MAIN_MENU/main_menu_bloc/mainmenu_bloc.dart';
import 'package:card_todo/TODO/buttonbloc/button_animation_bloc.dart';
import './widget_button_animation_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:card_todo/UTILS/icon/todo_app_icon_icons.dart';

const double buttonsize = 80;

// enum

class LinearFlowWidget extends StatefulWidget {
  const LinearFlowWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LinearFlowWidget> createState() => _LinearFlowWidgetState();
}

class _LinearFlowWidgetState extends State<LinearFlowWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  // bool isClicked

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

  void onPressedBuildUtama(BuildContext context) {
    context.read<ButtonAnimationBloc>().add(ActionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Flow(delegate: FlowMenuDelegate(controller: controller), children: [
      BuildItemUtama(
          title1: 'Action',
          title2: 'Close',
          onPressed: () {
            if (controller.isCompleted) {
              controller.reverse();
              onPressedBuildUtama(context);
              return;
            }
            if (controller.isAnimating) {
              return;
            }
            if (controller.isDismissed) {
              onPressedBuildUtama(context);
              controller.forward();
            }
          }),
      BuildItem(
          icon: Icons.add,
          title: 'Add',
          onPressed: () {
            controller.reset();
            context.read<ButtonAnimationBloc>().add(ActionAdd());
          }),
      BuildItem(
          icon: TodoAppIcon.convert,
          title: 'Reorder',
          onPressed: () {
            controller.reset();
            context.read<ButtonAnimationBloc>().add(ActionReorder());
            context.read<MainMenuBloc>().add(MainActionReorderButton(true));
          }),
      BuildItem(
          icon: TodoAppIcon.delete,
          title: 'Delete',
          onPressed: () {
            controller.reset();
            context.read<ButtonAnimationBloc>().add(ActionDelete());
            context.read<MainMenuBloc>().add(MainActionDeleteButton(true));
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
