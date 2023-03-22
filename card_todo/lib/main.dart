// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:card_todo/AUTH/pages/page_sign_in.dart';
import 'package:card_todo/AUTH/pages/page_sign_up.dart';
import 'package:card_todo/TODO/MAIN_MENU/page_main_menu.dart';
import 'package:card_todo/UTILS/static/size_class.dart';
import 'package:card_todo/general_bloc_observer.dart';
import 'package:card_todo/testfolder/hive/modelketiga/modelketiga.dart';
import 'package:card_todo/testfolder/testfile.dart';
import 'package:flutter/material.dart';
import './AUTH/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return App();
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: SingInPage(),
      // home: PageSignUp(),
      // home: TestGridCardPage(),
      home: TestPageFolder(),
      // home: MainMenuPage(),
    );
  }
}
