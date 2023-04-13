// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:card_todo/DATA/model/modelTodo.dart';
import 'package:card_todo/DATA/model/model_arguments.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/TODO/task_list/bloc_task/task_menu_bloc.dart';
import 'package:card_todo/TODO/utils/widget/widget_app_bar.dart';
import 'package:card_todo/TODO/utils/widget/widget_button_animation.dart';
import 'package:card_todo/TODO/utils/widget/widget_button_animation_helper.dart';
import 'package:card_todo/TODO/utils/widget/widget_task_page.dart';
import 'package:card_todo/UTILS/icon/todo_app_icon_icons.dart';
import 'package:card_todo/UTILS/static/enum_todo.dart';
import 'package:card_todo/UTILS/static/size_class.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_todo/TODO/bloc_button/button_animation_bloc.dart';
import 'package:reorderables/reorderables.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.titleTask});
  final String titleTask;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Sizing sizing = Sizing();
  @override
  Widget build(BuildContext context) {
    sizing.init(context);
    double paddingHorizontal = sizing.widthCalc(percent: 12);
    double heightAppBar = 70;
    TodoData todoData = RepositoryProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(heightAppBar),
        child: CustomAppBar(
          heightAppBar: heightAppBar,
          paddingHorizontal: paddingHorizontal / 2,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              widget.titleTask,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              ' Today you have ${todoData.trueListTask.length} tasks',
              style: TextStyle(fontSize: 12),
            ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                TodoAppIcon.previous,
                color: Colors.black,
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Today',
          //             style:
          //                 TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //           ),
          //           SizedBox(
          //             height: 3,
          //           ),
          //           Text(
          //             ' Today you have 4 tasks',
          //             style: TextStyle(fontSize: 12),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
      floatingActionButton:
          BlocBuilder<ButtonAnimationBloc, ButtonAnimationState>(
        builder: (context, state) {
          final buttonAnimationBloc = context.read<ButtonAnimationBloc>();
          if (state.actionEnum == ActionEnum.action &&
              state is ButtonActionState) {
            return LinearFlowWidget(
              isAction: true,
              whichTodoBloc: buttonAnimationBloc.whichTodoBloc,
            );
          }
          if (state.actionEnum == ActionEnum.action &&
              state is! ButtonActionState) {
            return LinearFlowWidget(
              isAction: false,
              whichTodoBloc: buttonAnimationBloc.whichTodoBloc,
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: DoneButton(
                actionEnum: state.actionEnum,
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
                  TaskReorderedProcess(oldIndex: oldIndex, newIndex: newIndex),
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
                bool isDelete = state.isRedList[index];
                String title = taskList[index].title;
                return TileTaskCard(
                    onTapDelete: () {
                      context
                          .read<TaskMenuBloc>()
                          .add(TaskDeleteProcess(index: index));
                    },
                    color:
                        isDelete ? const Color(0xFFFF6961) : Color(0xFFFFFFFF),
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
    );
  }
}
