import 'package:flutter/material.dart';

class ButtonAction extends StatelessWidget {
  const ButtonAction(
      {super.key,
      required this.labeltext,
      required this.onTap,
      this.color,
      this.height});

  final String labeltext;
  final Color? color;
  final double? height;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30)
            .copyWith(bottom: height ?? 10, top: height ?? 10),
        decoration: BoxDecoration(
          color: color ?? Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: Text(
          labeltext,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, letterSpacing: 3),
        ),
      ),
    );
  }
}

class LinkText extends StatelessWidget {
  const LinkText({
    super.key,
    required this.comment,
    required this.commentlink,
    required this.ontap,
  });

  final String comment;
  final String commentlink;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            comment,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
          InkWell(
            onTap: ontap,
            child: Text(
              commentlink,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
