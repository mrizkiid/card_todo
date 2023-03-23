import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/TODO/MAIN_MENU/main_menu_bloc/mainmenu_bloc.dart';
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
import 'package:card_todo/TODO/buttonbloc/button_animation_bloc.dart';
import 'package:reorderables/reorderables.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => MainMenuPageState();
}

class MainMenuPageState extends State<MainMenuPage> {
  TodoData todoData = TodoData();
  bool? isDelete = false;
  bool? isDone = false;
  Sizing sizing = Sizing();
  @override
  Widget build(BuildContext context) {
    sizing.init(context);
    double heightAppBar = sizing.heightCalc(percent: 22.3, min: 120);
    double paddingHorizontal = sizing.widthCalc(percent: 12);
    double fontCard = sizing.widthCalc(percent: 5.2);
    double sizeCard =
        sizing.sizeInCont(sizeParent: (sizing.screenWidth - 90), percent: 47);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ButtonAnimationBloc(whichTodoBloc: WhichTodoBloc.mainMenu),
        ),
        BlocProvider(
          create: (context) =>
              MainMenuBloc()..add(InitialList(listTitle: todoData.listTitle)),
        ),
      ],
      child: Scaffold(
        floatingActionButton: todoData.listTask.isEmpty
            ? const SizedBox()
            : BlocBuilder<ButtonAnimationBloc, ButtonAnimationState>(
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
                : MultiBlocListener(
                    listeners: [
                      BlocListener<MainMenuBloc, MainMenuState>(
                        listener: (context, state) {},
                      ),
                      BlocListener<ButtonAnimationBloc, ButtonAnimationState>(
                        listener: (context, state) {
                          if (state is DoneState) {
                            isDone = state.isSave ?? false;
                          }
                        },
                      ),
                    ],
                    child: BlocBuilder<MainMenuBloc, MainMenuState>(
                      builder: (context, state) {
                        /// draggabl grid
                        if (state is MainReorderButtonState) {
                          print('reordere');
                          return ReorderableWrap(
                            padding: EdgeInsets.symmetric(
                                    horizontal: paddingHorizontal)
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
                                  MainReorderProcessData(
                                      oldIndex: oldIndex, newIndex: newIndex));
                            },
                          );
                        }

                        if (state is MainDeleteButtonState) {
                          isDelete = state.isPressed;
                        }

                        ///Grid for delete and ordinary grid
                        return GridView.builder(
                          padding: EdgeInsets.symmetric(
                                  horizontal: paddingHorizontal)
                              .copyWith(bottom: 40),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: todoData.listTitle.length,
                          itemBuilder: (context, index) {
                            return CardWidget(
                              fontSize: fontCard,
                              title: state.listTitle[index],
                              tasktodo: todoData.listTask.length,
                              isDelete: isDelete,
                            );
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
        //
      ),
    );
  }
}
