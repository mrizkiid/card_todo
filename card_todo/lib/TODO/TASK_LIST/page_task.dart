// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:card_todo/TODO/TASK_LIST/tasklist.dart';
import 'package:card_todo/TODO/utils/widget/widget_button_animation.dart';
import 'package:card_todo/TODO/utils/widget/widget_button_animation_helper.dart';
import 'package:card_todo/UTILS/icon/todo_app_icon_icons.dart';
import 'package:card_todo/UTILS/static/color_class.dart';
import 'package:card_todo/UTILS/static/size_class.dart';
import 'package:card_todo/UTILS/widget/main_menu_button_flow.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_todo/TODO/buttonbloc/button_animation_bloc.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    Sizing sizing = Sizing();
    sizing.init(context);
    double paddingHorizontal = sizing.widthCalc(percent: 12);
    double heightAppBar = 65;
    bool isDelete = true;
    for (var i in taskList) {
      print('${i.isPressed} == ${i.title}');
    }
    List<taskModel> listTaskTrue =
        taskList.where((element) => element.isPressed == true).toList();
    List<taskModel> listTaskFalse =
        taskList.where((element) => element.isPressed == false).toList();
    List<taskModel> listTaskFinal = [...listTaskFalse, ...listTaskTrue];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(heightAppBar),
        child: Container(
          decoration: BoxDecoration(
            color: ColorStatic.maincolor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal)
                .copyWith(bottom: 10, top: 10),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        ' Today you have 4 tasks',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility,
                      size: 27,
                    ),
                  )
                ],
              ),
            ),
          ),
          // ch
        ),
      ),
      floatingActionButton:
          BlocBuilder<ButtonAnimationBloc, ButtonAnimationState>(
        builder: (context, state) {
          if (state.isShowPressed == false) {
            return const LinearFlowWidget();
          }
          return Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: DoneButton(
                actionEnum: state.actionEnum,
                todoData: todoData,
              ),
            ),
          );
        },
      ),
      body:
          // For addin if list null
          //
          //  Align(
          //   alignment: Alignment.center,
          //   child: IconButton(
          //     onPressed: () {
          //       print('add Pressed');
          //     },
          //     icon: Icon(
          //       TodoAppIcon.add,
          //       color: Colors.black.withOpacity(0.3),
          //       size: sizing.isPotrait ? 50 : 30,
          //     ),
          //   ),
          // ),

          ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal)
            .copyWith(top: 30),
        itemCount: listTaskFinal.length,
        itemBuilder: (context, index) {
          bool isPressed = listTaskFinal[index].isPressed;
          String title = listTaskFinal[index].title;
          return TileTaskCard(
            isChecked: isPressed,
            title: title,
            isDelete: isDelete,
            onchanged: () {
              print('pressed');
              isPressed = !isPressed;
              listTaskFinal[index] =
                  taskModel(isPressed: isPressed, title: title);
              taskList = [...listTaskFinal];
              setState(() {});
            },
          );
        },
      ),
    );
  }
}

class TileTaskCard extends StatelessWidget {
  final bool isChecked;
  final String title;
  final bool isDelete;
  final void Function() onchanged;
  const TileTaskCard({
    super.key,
    required this.isChecked,
    required this.title,
    required this.isDelete,
    required this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            if (isChecked)
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 2,
                color: Colors.black.withOpacity(0.07),
              )
            else
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 2,
                color: Colors.black.withOpacity(0.12),
              ),
          ],
        ),
        child: ListTile(
          leading: checkBoxCustom(isChecked, onchanged),
          title: Text(
            title,
            style: isChecked
                ? TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.3),
                    decoration: TextDecoration.lineThrough)
                : TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
          ),
          trailing: isDelete
              ? Icon(
                  TodoAppIcon.delete,
                  color: Colors.red,
                )
              : SizedBox(),
        ),
      ),
    );
  }

  Widget checkBoxCustom(bool isPressed, void Function() onchanged) {
    return IconButton(
      hoverColor: Colors.white,
      splashColor: Colors.white,
      onPressed: () {
        onchanged();
      },
      icon: isPressed
          ? Icon(
              TodoAppIcon.check,
              size: 27,
              color: Colors.black.withOpacity(0.3),
            )
          : Icon(
              TodoAppIcon.empty_checkbox,
              size: 20,
              color: Colors.black,
            ),
    );
  }
}
