import 'package:card_todo/TODO/utils/widget/widget_app_bar.dart';
import 'package:card_todo/UTILS/icon/todo_app_icon_icons.dart';
import 'package:card_todo/UTILS/static/size_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';

class PageAddMainMenu extends StatelessWidget {
  PageAddMainMenu({super.key});
  Sizing sizing = Sizing();
  String titleTodo = 'unknown';
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null) {
      titleTodo = ModalRoute.of(context)!.settings.arguments.toString();
    }
    sizing.init(context);
    double paddingHorizontal = sizing.widthCalc(percent: 12);
    double heightAppBar = 70;
    TodoData todoData = RepositoryProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(heightAppBar),
        child: CustomAppBar(
          paddingHorizontal: paddingHorizontal / 2,
          child: const Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Add Card',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              trailing: Icon(
                TodoAppIcon.previous,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
