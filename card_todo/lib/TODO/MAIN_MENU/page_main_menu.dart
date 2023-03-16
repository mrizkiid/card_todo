// ignore_for_file: prefer_const_constructors

import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/UTILS/icon/my_flutter_app_icons.dart';
import 'package:card_todo/UTILS/icon/todo_app_icon_icons.dart';
import 'package:card_todo/UTILS/static/color_class.dart';
import 'package:card_todo/UTILS/static/size_class.dart';
import 'package:flutter/material.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => MainMenuPageState();
}

class MainMenuPageState extends State<MainMenuPage> {
  TodoData todoData = TodoData();
  @override
  Widget build(BuildContext context) {
    Sizing sizing = Sizing();
    sizing.init(context);
    double heightAppBar = sizing.heightCalc(percent: 22.3, min: 120);
    double paddingHorizontal = sizing.widthCalc(percent: 12);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(heightAppBar),
        child: AppBar(
          elevation: 0,
          backgroundColor: ColorStatic.maincolor,
          flexibleSpace: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal)
                .copyWith(bottom: sizing.heightCalc(percent: 2.5)),
            height: 500,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  // height: 50,
                  // color: Colors.white,
                  child: Row(
                    children: [
                      // ignore: prefer_const_literals_to_create_immutables
                      Flexible(
                        flex: sizing.isPotrait ? 3 : 8,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, Rizki',
                              style: TextStyle(
                                  fontSize:
                                      sizing.heightCalc(percent: 5.7, max: 30),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'You Have 5 tasks',
                              style: TextStyle(
                                  fontSize:
                                      sizing.heightCalc(percent: 3.7, max: 15),
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          // flex: 1,
                          child: Image.asset('assets/images/profile.png'))
                    ],
                  ),
                  // color: Colors.black,
                ),
              ],
            ),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              TodoAppIcon.menu,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: sizing.heightCalc(percent: 10),
            decoration: BoxDecoration(
              color: ColorStatic.maincolor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal)
                .copyWith(bottom: 40),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemCount: todoData.listTitle.length,
            itemBuilder: (context, index) {
              return cardWidget(
                  // sizing.widthCalc(percent: 33.9),
                  sizing.widthCalc(percent: 5.2),
                  todoData.listTitle[index],
                  todoData.listTask.length);
            },
          ),
          Positioned(bottom: 20, right: 20, child: buttonActionWidget()),
        ],
      ),
      //
    );
  }

  Widget cardWidget(
    double fontSize,
    String title,
    int tasktodo,
  ) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25)),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: SizedBox(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: fontSize),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Visibility(
                  visible: false,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(TodoAppIcon.delete),
                  ),
                ),
              )
            ],
          ),
          Text('You have $tasktodo Tasks')
        ],
      ),
    );
  }

  Widget buttonActionWidget() {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text(
          'ACTION',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
