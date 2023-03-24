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

  const TaskEvent({
    required this.isChecked,
    required this.title,
    required this.index,
  });
}

class TaskDelete extends TaskMenuEvent {
  final bool isDelete;

  const TaskDelete(this.isDelete);
  // final
}

class TaskReorderedButton extends TaskMenuEvent {
  final bool isPressed;

  const TaskReorderedButton(this.isPressed);
}

class TaskReorderedProcess extends TaskMenuEvent {
  final int oldIndex;
  final int newIndex;

  const TaskReorderedProcess({required this.oldIndex, required this.newIndex});
}

class TaskReorderedSave extends TaskMenuEvent {}

class TaskSave extends TaskMenuEvent {}

// class TaskCh
