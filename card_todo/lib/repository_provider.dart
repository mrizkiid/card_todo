import 'package:card_todo/DATA/model/model_user.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepoProvide {
  RepoProvide();

  Widget init(Widget apps) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => UserModel(),
        ),
        RepositoryProvider(
          /// it will open the box
          create: (_) => TodoData(),
        )
      ],
      child: apps,
    );
  }
}
