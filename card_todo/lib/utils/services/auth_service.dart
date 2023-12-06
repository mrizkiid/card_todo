import 'package:card_todo/app/auth/pages/page_sign_in.dart';
import 'package:card_todo/app/todo/main_menu/page_main_menu.dart';
import 'package:card_todo/utils/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Widget handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        } else if (snapshot.hasData) {
          return const MainMenuPage();
        } else {
          return const SingInPage();
        }
      },
    );
  }

  // authlagi() {
  //   FirebaseAuth.instance.
  // }
}
