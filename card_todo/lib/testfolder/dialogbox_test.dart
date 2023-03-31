// import 'package:card_todo/TODO/utils/widget/widget_button_animation.dart';
// import 'package:card_todo/UTILS/static/color_class.dart';
// import 'package:flutter/material.dart';

// class dialogbox_test extends StatefulWidget {
//   const dialogbox_test({super.key});

//   @override
//   State<dialogbox_test> createState() => _dialogbox_testState();
// }

// class _dialogbox_testState extends State<dialogbox_test> {
//   void dialogAdd({required Widget child}) => showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           // insetPadding: EdgeInsets.zero,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(20))),
//           backgroundColor: ColorStatic.maincolor,
//           content: child,
//         ),
//         // builder: (context) => child,
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: IconButton(
//             onPressed: () {
//               dialogAdd(
//                   child: MainDialogAdd(
//                 width: 250,
//               ));
//             },
//             icon: const Icon(Icons.add)),
//       ),
//     );
//   }
// }
