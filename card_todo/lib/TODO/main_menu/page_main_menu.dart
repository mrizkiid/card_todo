import 'package:card_todo/DATA/model/modelArguments.dart';
import 'package:card_todo/DATA/model/modelTodo.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/TODO/main_menu/main_menu_bloc/mainmenu_bloc.dart';
import 'package:card_todo/TODO/utils/widget/widget_button_animation.dart';
import 'package:card_todo/TODO/utils/widget/widget_button_animation_helper.dart';
import 'package:card_todo/TODO/utils/widget/widget_main_menu.dart';
// import 'package:card_todo/UTILS/icon/my_flutter_app_icons.dart';
import 'package:card_todo/UTILS/icon/todo_app_icon_icons.dart';
import 'package:card_todo/UTILS/static/color_class.dart';
import 'package:card_todo/UTILS/static/enum_todo.dart';
import 'package:card_todo/UTILS/static/size_class.dart';
import 'package:card_todo/testfolder/hive/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_todo/TODO/bloc_button/button_animation_bloc.dart';
import 'package:reorderables/reorderables.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => MainMenuPageState();
}

class MainMenuPageState extends State<MainMenuPage> {
  bool? isDelete = false;
  bool? isDone = false;

  Sizing sizing = Sizing();
  @override
  Widget build(BuildContext context) {
    TodoData todoData = RepositoryProvider.of<TodoData>(context);
    sizing.init(context);
    double heightAppBar = sizing.heightCalc(percent: 22.3, min: 120);
    double paddingHorizontal = sizing.widthCalc(percent: 12);
    double fontCard = sizing.widthCalc(percent: 5.2);
    List<TitleList> listTitle = todoData.listTitle;
    double sizeCard =
        sizing.sizeInCont(sizeParent: (sizing.screenWidth - 90), percent: 47);
    return Scaffold(
      floatingActionButton: listTitle.isEmpty
          ? const SizedBox()
          : BlocBuilder<ButtonAnimationBloc, ButtonAnimationState>(
              builder: (context, state) {
                final buttonAnimationBloc = context.read<ButtonAnimationBloc>();
                if (state.actionEnum == ActionEnum.action &&
                    state is ButtonActionState) {
                  return LinearFlowWidget(
                    isAction: state.isAction,
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
                      todoData: todoData,
                    ),
                  ),
                );
              },
            ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(heightAppBar),
        child: ProfileContainer(
            paddingHorizontal: paddingHorizontal, sizing: sizing),
      ),
      body: Stack(
        children: [
          ///
          Container(
            height: sizing.heightCalc(percent: 10),
            decoration: const BoxDecoration(
              color: ColorStatic.maincolor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          ///
          // todoData.listTitle.isEmpty
          //     ? Align(
          //         alignment: Alignment.center,
          //         child: IconButton(
          //           onPressed: () {
          //             print('add button');
          //           },
          //           icon: Icon(
          //             TodoAppIcon.add,
          //             color: Colors.black.withOpacity(0.3),
          //             size: sizing.isPotrait ? 50 : 30,
          //           ),
          //         ),
          //       )
          //     :
          BlocBuilder<MainMenuBloc, MainMenuState>(
            builder: (context, state) {
              if (state is MainLoadingState) {
                return Container(
                  color: Colors.white.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              if (state.listTitle.isEmpty) {
                return Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      print('add button');
                    },
                    icon: Icon(
                      TodoAppIcon.add,
                      color: Colors.black.withOpacity(0.3),
                      size: sizing.isPotrait ? 50 : 30,
                    ),
                  ),
                );
              }

              /// This for reordere state
              /// if the state is in mainorederebuttonstate or in processs mean
              /// that reordere not finished yet untill user press save
              if (state is MainReorderState) {
                print('reordere');
                return ReorderableWrap(
                  padding: EdgeInsets.symmetric(horizontal: paddingHorizontal)
                      .copyWith(bottom: 40),
                  spacing: 10,
                  runSpacing: 10,
                  children: state.listTitle
                      .map(
                        (tile) => CardWidget(
                            fontSize: fontCard,
                            title: tile.title,
                            tasktodo: state.listTitle.length,
                            sizeCard: sizeCard,
                            isDelete: isDelete),
                      )
                      .toList(),
                  onReorder: (oldIndex, newIndex) {
                    context.read<MainMenuBloc>().add(
                        MainReorderProcessDataEvent(
                            oldIndex: oldIndex, newIndex: newIndex));
                  },
                );
              }

              if (state is MainDeleteState) {
                print('rebuild delete state');
                return GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: paddingHorizontal)
                      .copyWith(bottom: 40),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: todoData.listTitle.length,
                  itemBuilder: (context, index) {
                    bool isDelete = state.isRedList[index];
                    String title = state.listTitle[index].title;
                    int sumTask = state.listTitle[index].sumTask;
                    return CardWidget(
                      fontSize: fontCard,
                      color: isDelete ? const Color(0xFFFF6961) : Colors.white,
                      title: title,
                      tasktodo: sumTask,
                      isDelete: state.isPressed,
                      onpressed: () {
                        print('color pressed');
                        context
                            .read<MainMenuBloc>()
                            .add(MainDeleteProcessEvent(index: index));
                      },
                    );
                  },
                );
              }

              print('i am rendered');

              ///Grid for default
              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal)
                    .copyWith(bottom: 40),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: state.listTitle.length,
                itemBuilder: (context, index) {
                  String title = state.listTitle[index].title;
                  String keyValue = state.listTitle[index].keyValue;
                  int sumTask = state.listTitle[index].sumTask;
                  ScreenArguments args =
                      ScreenArguments(title: title, keyValue: keyValue);
                  print('default title ${state.listTitle.length}');
                  return CardWidget(
                    onpressed: () {
                      Navigator.of(context)
                          .pushNamed('/TaskPage', arguments: args);
                    },
                    fontSize: fontCard,
                    title: title,
                    tasktodo: sumTask,
                    isDelete: false,
                  );
                },
              );
            },
          ),
        ],
      ),
      //
    );
  }
}
