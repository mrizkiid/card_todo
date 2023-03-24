// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:card_todo/AUTH/cubit/password_cubit.dart';
import 'package:card_todo/AUTH/pages/page_sign_up.dart';
import 'package:card_todo/AUTH/pages/size/size_auth.dart';
import 'package:card_todo/TODO/main_menu/page_main_menu.dart';
import 'package:card_todo/UTILS/static/color_class.dart';
import 'package:card_todo/UTILS/static/size_class.dart';
import 'package:card_todo/UTILS/widget/button.dart';
import 'package:card_todo/UTILS/widget/input_card.dart';
import 'package:flutter/material.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  Color maincolor = ColorStatic.maincolor;
  PasswordCubit passwordCubit = PasswordCubit(true);
  TextEditingController usernameCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();

  @override
  void dispose() {
    usernameCtr.dispose();
    passwordCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Sizing sizing = Sizing();
    sizing.init(context);
    SizeAuth sizeAuth = SizeAuth();
    sizeAuth.init(sizing);
    // double heightScreen = InitSizing().screenHeight;
    double widthScreen = sizing.screenWidth;
    double heightHeader = sizing.heightCalc(percent: 24, min: 200);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            color: maincolor,
            height: sizing.heightCalc(percent: 50, min: 350),
          ),
          ListView(children: [
            //logo
            SizedBox(
              height: heightHeader,
              // padding: EdgeInsets.only(left: sizing.widthCalc(percent: 10)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: sizing.sizeInCont(
                          sizeParent: heightHeader,
                          percent: 50,
                          min: 50,
                          max: 200),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.contain)),
                    ),
                  ],
                ),
              ),
              //     Image.asset(
              //   'assets/images/logo.png',
              //   height: 100,
              //   width: 100,
              // )
            ),

            //signUP
            Container(
              // padding: EdgeInsets.only(top: sizing.heightCalc(percent: 5.9)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: sizing.heightCalc(percent: 5.9),
                  bottom: 20,
                  left: sizing.widthCalc(percent: 13.6),
                  right: sizing.widthCalc(percent: 13.6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: sizing.heightCalc(percent: 5.9),
                    ),
                    InputCard(
                        titletext: 'Email / User Name',
                        labeltext: 'youremail@gmail.com',
                        controller: usernameCtr),
                    SizedBox(
                      height: sizing.heightCalc(percent: 3.2),
                    ),
                    InputCardPassword(
                      titletext: 'Password',
                      labeltext: 'Password',
                      controller: passwordCtr,
                      passwordCubit: passwordCubit,
                    ),
                    SizedBox(
                      height: sizing.heightCalc(percent: 7),
                    ),
                    ButtonAction(
                        labeltext: 'SIGN IN',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainMenuPage(),
                              ));
                          print(
                              'Username : ${usernameCtr.text} == Password : ${passwordCtr.text}');
                        }),
                    SizedBox(
                      height: sizing.heightCalc(percent: 3.46),
                    ),
                    LinkText(
                        comment: 'Don\'t have any account ? ',
                        commentlink: 'Sign Up',
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageSignUp(),
                              ));
                          print('login');
                        }),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
