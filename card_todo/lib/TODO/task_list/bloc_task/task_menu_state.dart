// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_menu_bloc.dart';

abstract class TaskMenuState extends Equatable {
  const TaskMenuState({required this.taskList, required this.sumTask});
  final List<TaskList> taskList;
  final int sumTask;
  @override
  List<Object?> get props => [taskList, sumTask];
}

class TaskMenuInitial extends TaskMenuState {
  const TaskMenuInitial({required super.taskList, required super.sumTask});
}

class TaskState extends TaskMenuState {
  const TaskState({required super.taskList, required super.sumTask});
}

class TaskSaveState extends TaskMenuState {
  const TaskSaveState({required super.sumTask, required super.taskList});
}

class TaskReorderState extends TaskMenuState {
  final List<TaskList> taskListFalse;
  final bool isOrdered;
  const TaskReorderState(
      {required super.taskList,
      required super.sumTask,
      required this.taskListFalse,
      required this.isOrdered});

  @override
  List<Object?> get props => [isOrdered, taskListFalse];
}

class TaskDeleteState extends TaskMenuState {
  final bool isDelete;
  final List<bool> isRedList;

  const TaskDeleteState(
      {required this.isRedList,
      required super.sumTask,
      required this.isDelete,
      required super.taskList});

  @override
  List<Object?> get props => [isDelete, isRedList];
}
