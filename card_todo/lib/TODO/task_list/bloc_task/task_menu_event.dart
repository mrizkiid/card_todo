// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_menu_bloc.dart';

abstract class TaskMenuEvent extends Equatable {
  const TaskMenuEvent();

  @override
  List<Object> get props => [];
}

class TaskInitialList extends TaskMenuEvent {
  List<TaskList> taskList;
  TaskInitialList({
    required this.taskList,
  });
}

class TaskEvent extends TaskMenuEvent {
  final bool isChecked;
  final String title;
  final int index;

  const TaskEvent(this.isChecked, this.title, this.index);
}

class TaskDelete extends TaskMenuEvent {
  final bool isDelete;

  const TaskDelete(this.isDelete);
  // final
}

// class TaskCh
