// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_menu_bloc.dart';

abstract class TaskMenuEvent extends Equatable {
  const TaskMenuEvent();

  @override
  List<Object> get props => [];
}

class TaskInitialList extends TaskMenuEvent {
  TaskInitialList();
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

  // @override
  // List<Object> get props => [isChecked, title, index];
}

class TaskDelete extends TaskMenuEvent {
  final bool isDelete;

  const TaskDelete(this.isDelete);
  @override
  List<Object> get props => [isDelete];
}

class TaskDeleteProcess extends TaskMenuEvent {
  final int index;
  const TaskDeleteProcess({required this.index});
}

class TaskReordered extends TaskMenuEvent {
  final bool isOrdered;

  const TaskReordered(this.isOrdered);
  @override
  List<Object> get props => [isOrdered];
}

class TaskReorderedProcess extends TaskMenuEvent {
  final int oldIndex;
  final int newIndex;

  const TaskReorderedProcess({required this.oldIndex, required this.newIndex});
}

class TaskReorderedSave extends TaskMenuEvent {}

class TaskReorderSave extends TaskMenuEvent {}

class TaskDeleteSave extends TaskMenuEvent {}

// class TaskCh
