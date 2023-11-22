import 'package:card_todo/data/data_sources/local/todo_data_local_source.dart';
import 'package:card_todo/data/model/model_user.dart';
import 'package:card_todo/data/repositories/todo_data.dart';
import 'package:card_todo/data/repositories/todo_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepoProvide {
  RepoProvide();
  final TodoDataLocalSource _todoDataLocalSource = TodoDataLocalSourceImpl();

  Widget init(Widget apps) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => UserModel(),
        ),
        RepositoryProvider(
          /// it will open the box
          create: (_) => TodoRepoImpl(_todoDataLocalSource),
        )
      ],
      child: apps,
    );
  }
}
