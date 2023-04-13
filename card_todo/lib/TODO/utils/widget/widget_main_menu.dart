import 'package:card_todo/UTILS/static/color_class.dart';
import 'package:card_todo/UTILS/static/size_class.dart';
import 'package:flutter/material.dart';
import 'package:card_todo/UTILS/icon/todo_app_icon_icons.dart';

///Make Containein above main menu
class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    super.key,
    required this.paddingHorizontal,
    required this.sizing,
    required this.sumTask,
    required this.name,
  });

  final double paddingHorizontal;
  final Sizing sizing;
  final int sumTask;
  final String name;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              child: Row(
                children: [
                  Flexible(
                    flex: sizing.isPotrait ? 3 : 8,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, $name',
                          style: TextStyle(
                              fontSize:
                                  sizing.heightCalc(percent: 5.7, max: 30),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'You Have $sumTask tasks',
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
        icon: const Icon(
          TodoAppIcon.menu,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
}

/// make cardwidget title for main menu
class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.fontSize,
    required this.title,
    required this.tasktodo,
    this.isDelete,
    this.sizeCard,
    this.index,
    this.onpressed,
    this.color,
  });

  final double fontSize;
  final String title;
  final int tasktodo;
  final bool? isDelete;
  final double? sizeCard;
  final int? index;
  final void Function()? onpressed;
  final Color? color;
//
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        padding: const EdgeInsets.all(20),
        height: sizeCard,
        width: sizeCard,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
            color: color ?? Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(2, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25),
              ),
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
                    visible: isDelete ?? false,
                    child: const Icon(TodoAppIcon.delete),
                  ),
                )
              ],
            ),
            Text('You have $tasktodo Tasks')
          ],
        ),
      ),
    );
  }
}
