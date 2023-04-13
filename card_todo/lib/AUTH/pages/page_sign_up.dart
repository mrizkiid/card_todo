// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:card_todo/AUTH/cubit/password_cubit.dart';
import 'package:card_todo/UTILS/static/color_class.dart';
import 'package:card_todo/UTILS/static/size_class.dart';
import 'package:card_todo/UTILS/widget/button.dart';
import 'package:card_todo/UTILS/widget/input_card.dart';
import 'package:flutter/material.dart';

class PageSignUp extends StatefulWidget {
  const PageSignUp({super.key});

  @override
  State<PageSignUp> createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
  TextEditingController nicknamectr = TextEditingController();
  TextEditingController namectr = TextEditingController();
  TextEditingController emailctr = TextEditingController();
  TextEditingController passwordctr = TextEditingController();

  PasswordCubit passwordCubit = PasswordCubit(true);

  @override
  void dispose() {
    passwordCubit.close();
    nicknamectr.dispose();
    namectr.dispose();
    emailctr.dispose();
    passwordctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Sizing sizing = Sizing();
    sizing.init(context);
    double heightscreen = sizing.screenHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            color: ColorStatic.maincolor,
            height: sizing.sizeInCont(sizeParent: heightscreen, percent: 40),
          ),
          ListView(
            children: [
              SizedBox(
                height:
                    sizing.sizeInCont(sizeParent: heightscreen, percent: 15),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: sizing.widthCalc(percent: 8),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  // top: sizing.heightCalc(percent: 5.9),
                  bottom: 20,
                  left: sizing.widthCalc(percent: 13.6),
                  right: sizing.widthCalc(percent: 13.6),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: sizing.sizeInCont(
                            sizeParent: heightscreen, percent: 5),
                      ),
                      InputCard(
                          controller: nicknamectr,
                          titletext: 'Nickname',
                          labeltext: 'agus'),
                      SizedBox(
                        height: sizing.sizeInCont(
                            sizeParent: heightscreen, percent: 3.23),
                      ),
                      InputCard(
                          controller: namectr,
                          titletext: 'Full Name',
                          labeltext: 'Agus Ringgo'),
                      SizedBox(
                        height: sizing.sizeInCont(
                            sizeParent: heightscreen, percent: 3.23),
                      ),
                      InputCard(
                          controller: emailctr,
                          titletext: 'Email',
                          labeltext: 'Agus.Ringgo@gmail.com'),
                      SizedBox(
                        height: sizing.sizeInCont(
                            sizeParent: heightscreen, percent: 3.23),
                      ),
                      InputCardPassword(
                        titletext: 'Password',
                        labeltext: 'Password',
                        controller: passwordctr,
                        passwordCubit: passwordCubit,
                      ),
                      SizedBox(
                        height: sizing.sizeInCont(
                            sizeParent: heightscreen, percent: 3.68),
                      ),
                      ButtonAction(
                          labeltext: 'Sign Up',
                          onTap: () {
                            print('nickname : ${nicknamectr.text};');
                            print('User Name : ${namectr.text};');
                            print('emai; : ${emailctr.text};');
                            print('password : ${passwordctr.text};');
                          }),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
