// import 'package:flutter/material.dart';

// const double buttonsize = 80;

// class LinearFlowWidget extends StatefulWidget {
//   const LinearFlowWidget(
//       {Key? key, required this.title, required this.onpressed})
//       : super(key: key);

//   final String title;
//   final VoidCallback onpressed;

//   @override
//   State<LinearFlowWidget> createState() => _LinearFlowWidgetState();
// }

// class _LinearFlowWidgetState extends State<LinearFlowWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   @override
//   void initState() {
//     controller = AnimationController(
//         duration: const Duration(milliseconds: 300), vsync: this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Flow(delegate: FlowMenuDelegate(controller: controller), children: [
//       buildItem(Icons.menu, () {
//         print('Icon Menu');
//       }),
//       buildItem(Icons.mail, () {
//         print('Icon Mail');
//       }),
//       buildItem(Icons.call, () {
//         print('Icon Call');
//       }),
//       buildItem(Icons.notifications, () {
//         print('Icon Notifications');
//       })
//     ]);
//   }

//   Widget buildItem(IconData icon, VoidCallback onpressed) {
//     return Container(
//       width: buttonsize * 2,
//       height: buttonsize - 20,
//       decoration: const BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.all(Radius.circular(20))),
//       child: FloatingActionButton(
//         onPressed: () {
//           // onpressed();
//           if (controller.status == AnimationStatus.completed) {
//             controller.reverse();
//           } else {
//             controller.forward();
//           }
//         },
//         elevation: 0,
//         splashColor: Colors.black,
//         child: Icon(
//           icon,
//           color: Colors.white,
//           size: 45,
//         ),
//       ),
//     );
//   }
// }

// class FlowMenuDelegate extends FlowDelegate {
//   final Animation<double> controller;

//   const FlowMenuDelegate({required this.controller})
//       : super(repaint: controller);
//   @override
//   void paintChildren(FlowPaintingContext context) {
//     // context.paintChild(0, transform: Matrix4.translationValues(0, 0, 0));
//     final size = context.size;
//     final xstart = size.width - context.getChildSize(0)!.width - 20;
//     final ystart = size.height - context.getChildSize(0)!.height - 20;

//     for (var i = context.childCount - 1; i >= 0; i--) {
//       int margin = 10;
//       final childSize = context.getChildSize(i)!.height;
//       double dx = (childSize + margin) * i;
//       // margin = margin - 10;

//       final x = xstart;
//       final y = ystart - (dx * controller.value);
//       context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
//     }
//   }

//   @override
//   bool shouldRepaint(covariant FlowDelegate oldDelegate) {
//     return false;
//   }
// }
