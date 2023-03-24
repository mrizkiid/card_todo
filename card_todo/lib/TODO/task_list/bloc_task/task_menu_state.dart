// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_menu_bloc.dart';

abstract class TaskMenuState extends Equatable {
  const TaskMenuState({
    required this.taskList,
  });
  final List<TaskList> taskList;
  @override
  // TODO: implement props
  List<Object?> get props => [taskList];
}

class TaskMenuInitial extends TaskMenuState {
  TaskMenuInitial({required super.taskList});

  // @override
  // List<Object> get props => [taskList];
}

class TaskState extends TaskMenuState {
  TaskState({required super.taskList});

  // @override
  // List<Object> get props => [itaskList];
}
