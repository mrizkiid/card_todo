// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/TODO/task_list/bloc_task/task_menu_bloc.dart';
import 'package:card_todo/TODO/utils/widget/widget_button_animation.dart';
import 'package:card_todo/TODO/utils/widget/widget_button_animation_helper.dart';
import 'package:card_todo/UTILS/icon/todo_app_icon_icons.dart';
import 'package:card_todo/UTILS/static/color_class.dart';
import 'package:card_todo/UTILS/static/enum_todo.dart';
import 'package:card_todo/UTILS/static/size_class.dart';
import 'package:card_todo/UTILS/widget/main_menu_button_flow.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_todo/TODO/bloc_button/button_animation_bloc.dart';
import 'package:reorderables/reorderables.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Sizing sizing = Sizing();
  @override
  Widget build(BuildContext context) {
    sizing.init(context);
    double paddingHorizontal = sizing.widthCalc(percent: 12);
    double heightAppBar = 65;
    bool isDelete = false;
    TodoData todoData = RepositoryProvider.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ButtonAnimationBloc>(
          create: (context) =>
              ButtonAnimationBloc(whichTodoBloc: WhichTodoBloc.taskMenu),
        ),
        BlocProvider<TaskMenuBloc>(
            create: (context) => TaskMenuBloc(todoData: todoData)),
      ],
      child: Scaffold(
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal)
                  .copyWith(bottom: 10, top: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.visibility,
                    //     size: 27,
                    //   ),
                    // )
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
            if (state.actionEnum == ActionEnum.action &&
                state is ButtonActionState) {
              return LinearFlowWidget(
                isAction: state.isAction,
              );
            }
            if (state.actionEnum == ActionEnum.action &&
                state is! ButtonActionState) {
              return LinearFlowWidget(
                isAction: false,
              );
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

            BlocBuilder<TaskMenuBloc, TaskMenuState>(
          builder: (context, state) {
            final taskMenuBloc = context.read<TaskMenuBloc>();
            List<TaskList> taskList = state.taskList;

            ///reordered state
            if (state is TaskReorderState) {
              int i = -1;
              return ReorderableColumn(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal)
                    .copyWith(top: 30),
                onReorder: (oldIndex, newIndex) {
                  taskMenuBloc.add(
                    TaskReorderedProcess(
                        oldIndex: oldIndex, newIndex: newIndex),
                  );
                },
                children: state.taskListFalse
                    .map((e) {
                      i++;
                      return TileTaskCard(
                          key: ValueKey(i),
                          isChecked: e.isChecked,
                          title: e.title,
                          isDelete: false,
                          onchanged: () {});
                    })
                    .toList()
                    .cast<Widget>(),
              );
            }

            /// Delete state
            if (state is TaskDeleteState) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal)
                    .copyWith(top: 30),
                itemCount: state.taskList.length,
                itemBuilder: (context, index) {
                  bool isChecked = taskList[index].isChecked;
                  String title = taskList[index].title;
                  return TileTaskCard(
                      isChecked: isChecked,
                      title: title,
                      isDelete: true,
                      onchanged: () {});
                },
              );
            }

            // if (state is! TaskDeleteState) {
            //   isDelete = false;
            // }

            print('rebuild');

            /// it will build if not reordered
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal)
                  .copyWith(top: 30),
              itemCount: state.taskList.length,
              itemBuilder: (context, index) {
                bool isChecked = taskList[index].isChecked;
                String title = taskList[index].title;
                return TileTaskCard(
                  isChecked: isChecked,
                  title: title,
                  isDelete: false,
                  onchanged: () {
                    print('checked is pressed');
                    taskMenuBloc.add(TaskEvent(
                        isChecked: isChecked, title: title, index: index));
                  },
                );
              },
            );
          },
        ),
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
          leading: checkBoxCustom(isChecked, onchanged, isDelete),
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
              ? IconButton(
                  onPressed: () {
                    context.read<TaskMenuBloc>().add(TaskDeleteProcess());
                  },
                  icon: Icon(
                    TodoAppIcon.delete,
                    color: Colors.red,
                  ),
                )
              : SizedBox(),
        ),
      ),
    );
  }

  Widget checkBoxCustom(
      bool isPressed, void Function() onchanged, bool isDelete) {
    return IconButton(
      hoverColor: Colors.white,
      splashColor: Colors.white,
      onPressed: isDelete
          ? null
          : () {
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
