import 'package:card_todo/UTILS/icon/todo_app_icon_icons.dart';
import 'package:flutter/material.dart';

class TileTaskCard extends StatelessWidget {
  final bool isChecked;
  final String title;
  final bool isDelete;
  final void Function() onchanged;
  final void Function()? onTapDelete;
  final Color? color;
  const TileTaskCard({
    super.key,
    required this.isChecked,
    required this.title,
    required this.isDelete,
    required this.onchanged,
    this.onTapDelete,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: onTapDelete,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: color ?? const Color(0xFFFFFFFF),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: [
              if (isChecked)
                BoxShadow(
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                  spreadRadius: 2,
                  color: Colors.black.withOpacity(0.07),
                )
              else
                BoxShadow(
                  blurRadius: 4,
                  offset: const Offset(0, 2),
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
                  : const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
            ),
            trailing: isDelete
                ? const Icon(
                    TodoAppIcon.delete,
                    color: Colors.red,
                  )
                : const SizedBox(),
          ),
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
          : const Icon(
              TodoAppIcon.empty_checkbox,
              size: 20,
              color: Colors.black,
            ),
    );
  }
}
