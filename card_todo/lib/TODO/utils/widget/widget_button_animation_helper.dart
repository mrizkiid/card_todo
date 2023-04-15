// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_todo/TODO/bloc_button/button_animation_bloc.dart';
import 'package:card_todo/TODO/main_menu/main_menu_bloc/mainmenu_bloc.dart';
import 'package:card_todo/TODO/task_list/bloc_task/task_menu_bloc.dart';
import 'package:card_todo/UTILS/static/enum_todo.dart';

class BuildItem extends StatelessWidget {
  const BuildItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 60,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
          width: 140,
          height: 55,
          decoration: BoxDecoration(
              color: const Color(0xfffefeb1),
              border: Border.all(width: 2, color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  flex: 2,
                  child: SizedBox(
                    height: 55,
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        icon,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                  )),
              Flexible(
                flex: 3,
                child: SizedBox(
                  height: 55,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BuildItemUtama extends StatelessWidget {
  const BuildItemUtama({
    Key? key,
    required this.title1,
    required this.title2,
    required this.onPressed,
    required this.isAction,
  }) : super(key: key);

  final String title1;
  final String title2;
  final bool isAction;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
          width: 140,
          height: 55,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (isAction) ? title2 : title1,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoneButton extends StatelessWidget {
  const DoneButton({
    Key? key,
    required this.actionEnum,
  }) : super(key: key);

  final ActionEnum actionEnum;

  void showDialogMehtod(
    BuildContext context, {
    required String titleHead,
    required String titleSubHead,
    required String button,
    required ButtonAnimationBloc buttonAnimationBloc,
    MainMenuBloc? mainMenuBloc,
    TaskMenuBloc? taskMenuBloc,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titleHead),
          content: Text(titleSubHead),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(button),
              onPressed: () {
                if (taskMenuBloc != null) {
                  if (buttonAnimationBloc.actionEnum == ActionEnum.delete) {
                    taskMenuBloc.add(TaskDeleteSave());
                  }
                  if (buttonAnimationBloc.actionEnum == ActionEnum.reorder) {
                    taskMenuBloc.add(TaskReorderSave());
                  }
                }
                if (mainMenuBloc != null) {
                  // mainMenuBloc.add(MainReorderSaveEvent());
                  if (buttonAnimationBloc.actionEnum == ActionEnum.delete) {
                    if (mainMenuBloc.isListNull) {
                      buttonAnimationBloc.add(ButtonEmptyEvent());
                    }
                    mainMenuBloc.add(MainDeleteSaveEvent());
                  }
                  if (buttonAnimationBloc.actionEnum == ActionEnum.reorder) {
                    mainMenuBloc.add(MainReorderSaveEvent());
                  }
                }
                buttonAnimationBloc.add(const ButtonDoneEvent(isSave: false));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ButtonAnimationBloc buttonAnimationBloc;
    MainMenuBloc? mainMenuBloc;
    TaskMenuBloc? taskMenuBloc;
    buttonAnimationBloc = context.read<ButtonAnimationBloc>();
    if (buttonAnimationBloc.whichTodoBloc == WhichTodoBloc.mainMenu) {
      mainMenuBloc = context.read<MainMenuBloc>();
    }

    if (buttonAnimationBloc.whichTodoBloc == WhichTodoBloc.taskMenu) {
      taskMenuBloc = context.read<TaskMenuBloc>();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // done button
        InkWell(
          onTap: () {
            bool isDelete =
                (buttonAnimationBloc.actionEnum == ActionEnum.delete)
                    ? true
                    : false;
            bool isReorder =
                (buttonAnimationBloc.actionEnum == ActionEnum.reorder)
                    ? true
                    : false;
            if (isDelete) {
              showDialogMehtod(context,
                  buttonAnimationBloc: buttonAnimationBloc,
                  mainMenuBloc: mainMenuBloc,
                  taskMenuBloc: taskMenuBloc,
                  titleHead: 'Are You Sure ?',
                  titleSubHead:
                      'Tasks that have been deleted will not be restored !',
                  button: 'Delete');
              return;
            }
            if (isReorder) {
              showDialogMehtod(context,
                  buttonAnimationBloc: buttonAnimationBloc,
                  mainMenuBloc: mainMenuBloc,
                  taskMenuBloc: taskMenuBloc,
                  titleHead: 'Save the changes',
                  titleSubHead: 'Are you want to save the changes ? ',
                  button: 'Save');
              return;
            }
          },
          child: Container(
            height: 40,
            width: 74,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(left: 11),
                child: Text(
                  'Done',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 2,
        ),

        //cancel button
        InkWell(
          onTap: () {
            if (buttonAnimationBloc.whichTodoBloc == WhichTodoBloc.mainMenu &&
                mainMenuBloc != null) {
              mainMenuBloc.add(InitialListEvent());
            }

            if (buttonAnimationBloc.whichTodoBloc == WhichTodoBloc.taskMenu &&
                taskMenuBloc != null) {
              taskMenuBloc.add(const TaskInitialList());
            }
            buttonAnimationBloc.add(ButtonCancelEvent());
          },
          child: Container(
            height: 40,
            width: 74,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(right: 11),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
