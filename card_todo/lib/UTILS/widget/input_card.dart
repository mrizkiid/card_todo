// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:card_todo/AUTH/cubit/password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputCard extends StatefulWidget {
  const InputCard({
    super.key,
    required this.controller,
    required this.titletext,
    required this.labeltext,
  });

  final String titletext;
  final String labeltext;
  final TextEditingController controller;

  @override
  State<InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 4,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.25),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titletext,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          Center(
            child: TextField(
              controller: widget.controller,
              style: TextStyle(fontSize: 16, color: Colors.black),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                focusColor: Colors.black,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black)),
                label: Text(widget.labeltext),
                labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputCardPassword extends StatefulWidget {
  const InputCardPassword({
    super.key,
    required this.controller,
    required this.titletext,
    required this.labeltext,
    required this.passwordCubit,
  });

  final String titletext;
  final String labeltext;
  final TextEditingController controller;
  final PasswordCubit passwordCubit;

  @override
  State<InputCardPassword> createState() => _InputCardPasswordState();
}

class _InputCardPasswordState extends State<InputCardPassword> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 4,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.25),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titletext,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          Center(
            child: BlocBuilder<PasswordCubit, PasswordState>(
              bloc: widget.passwordCubit,
              builder: (context, state) {
                print(state);
                return TextField(
                  controller: widget.controller,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  cursorColor: Colors.black,
                  obscureText: state.isvisible,
                  onTap: () {},
                  // textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    focusColor: Colors.black,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    label: Text(widget.labeltext),
                    // labelText: widget.labeltext,
                    labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    suffixIcon: InkWell(
                        onTap: () {
                          widget.passwordCubit.passwordEvent();
                        },
                        child: state.isvisible
                            ? Icon(
                                Icons.visibility,
                                size: 24,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.visibility_off,
                                size: 24,
                                color: Colors.black,
                              )),
                    // suffix: IconButton(

                    //     padding: EdgeInsets.zero,
                    //     onPressed: () {
                    //       widget.passwordCubit.passwordEvent();
                    //     },
                    //     icon: state.isvisible
                    //         ? Icon(Icons.visibility)
                    //         : Icon(Icons.visibility_off)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class InputCardPassword extends StatelessWidget {
//   const InputCardPassword(
//       {super.key,
//       required this.labeltext,
//       required this.controller,
//       required this.titletext});

//   final String titletext;
//   final String labeltext;
//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(25)),
//           boxShadow: [
//             BoxShadow(
//               offset: Offset(0, 1),
//               blurRadius: 4,
//               spreadRadius: 1,
//               color: Colors.black.withOpacity(0.25),
//             ),
//           ]),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(titletext),
//           Center(
//             child: TextField(
//               controller: controller,
//               style: TextStyle(fontSize: 16, color: Colors.black),
//               cursorColor: Colors.black,
//               decoration: InputDecoration(
//                 focusColor: Colors.black,
//                 focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(width: 1, color: Colors.black)),
//                 label: Text(labeltext),
//                 labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
//                 floatingLabelBehavior: FloatingLabelBehavior.never,
//                 enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black, width: 1)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
