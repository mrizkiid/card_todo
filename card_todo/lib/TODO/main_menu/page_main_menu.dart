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
    double sizeCard =
        sizing.sizeInCont(sizeParent: (sizing.screenWidth - 90), percent: 47);
    return Scaffold(
      floatingActionButton: todoData.listTask.isEmpty
          ? const SizedBox()
          : BlocBuilder<ButtonAnimationBloc, ButtonAnimationState>(
              builder: (context, state) {
                if (state.actionEnum == ActionEnum.action &&
                    state is ButtonActionState) {
                  return LinearFlowWidget(
                    isAction: state.isAction,
                  );
                }
                if (state.actionEnum == ActionEnum.action &&
                    state is! ButtonActionState) {
                  return const LinearFlowWidget(
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
          todoData.listTitle.isEmpty
              ? Align(
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
                )
              : BlocBuilder<MainMenuBloc, MainMenuState>(
                  builder: (context, state) {
                    /// This for reordere state
                    /// if the state is in mainorederebuttonstate or in processs mean
                    /// that reordere not finished yet untill user press save
                    if (state is MainReorderState) {
                      print('reordere');
                      return ReorderableWrap(
                        padding:
                            EdgeInsets.symmetric(horizontal: paddingHorizontal)
                                .copyWith(bottom: 40),
                        spacing: 10,
                        runSpacing: 10,
                        children: state.listTitle
                            .map(
                              (tile) => CardWidget(
                                  fontSize: fontCard,
                                  title: tile,
                                  tasktodo: todoData.listTask.length,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: paddingHorizontal)
                                .copyWith(bottom: 40),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: todoData.listTitle.length,
                        itemBuilder: (context, index) {
                          bool isDelete = state.isRedList[index];
                          return CardWidget(
                            fontSize: fontCard,
                            color: isDelete
                                ? const Color(0xFFFF6961)
                                : Colors.white,
                            title: state.listTitle[index],
                            tasktodo: todoData.listTask.length,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: paddingHorizontal)
                              .copyWith(bottom: 40),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: todoData.listTitle.length,
                      itemBuilder: (context, index) {
                        String arg = todoData.listTitle[index];
                        return CardWidget(
                          onpressed: () {
                            Navigator.of(context)
                                .pushNamed('/TaskPage', arguments: arg);
                          },
                          fontSize: fontCard,
                          title: state.listTitle[index],
                          tasktodo: todoData.listTask.length,
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
