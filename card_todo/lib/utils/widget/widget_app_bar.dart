import 'package:card_todo/utils/static/color_class.dart';
import 'package:flutter/material.dart';

// class CustomAppBar extends PreferredSize {
//   final double heightAppBar;
//   final double paddingHorizontal;
//   final Widget child;

//   CustomAppBar(
//       {super.key,
//       required this.heightAppBar,
//       required this.paddingHorizontal,
//       required this.child})
//       : super(
//           preferredSize: Size.fromHeight(heightAppBar),
//           child: Container(
//             decoration: const BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(25),
//                 bottomRight: Radius.circular(25),
//               ),
//             ),
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: paddingHorizontal)
//                   .copyWith(bottom: 10, top: 10),
//               child: child,
//             ),
//           ),
//         );
// }

class CustomAppBar extends StatelessWidget {
  final double heightAppBar;
  final double paddingHorizontal;
  final Widget child;
  const CustomAppBar({
    super.key,
    required this.heightAppBar,
    required this.paddingHorizontal,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorStatic.maincolor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: SafeArea(child: child),
      ),
    );
  }
}
