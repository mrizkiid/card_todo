// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_menu_bloc.dart';

abstract class TaskMenuState extends Equatable {
  const TaskMenuState({
    required this.taskList,
  });
  final List<TaskList> taskList;
  @override
  List<Object?> get props => [taskList];
}

class TaskMenuInitial extends TaskMenuState {
  const TaskMenuInitial({required super.taskList});

  // @override
  // List<Object> get props => [taskList];
}

class TaskState extends TaskMenuState {
  const TaskState({required super.taskList});

  // @override
  // List<Object> get props => [itaskList];
}

class TaskReorderState extends TaskMenuState {
  final List<TaskList> taskListFalse;
  final bool isOrdered;
  const TaskReorderState(
      {required super.taskList,
      required this.taskListFalse,
      required this.isOrdered});

  @override
  List<Object?> get props => [isOrdered, taskListFalse];
}

class TaskDeleteState extends TaskMenuState {
  final bool isDelete;

  const TaskDeleteState({required this.isDelete, required super.taskList});

  @override
  List<Object?> get props => [isDelete];
}
