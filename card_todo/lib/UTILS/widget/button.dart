import 'package:flutter/material.dart';

class ButtonAction extends StatelessWidget {
  const ButtonAction({super.key, required this.labeltext, required this.onTap});

  final String labeltext;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30)
            .copyWith(bottom: 10, top: 10),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(25)),
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
