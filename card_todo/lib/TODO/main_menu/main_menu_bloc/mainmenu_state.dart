// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mainmenu_bloc.dart';

abstract class MainMenuState extends Equatable {
  const MainMenuState(this.listTitle);

  final List<String> listTitle;

  @override
  List<Object?> get props => [listTitle];
}

class MainmenuInitial extends MainMenuState {
  const MainmenuInitial(super.listTitle);
}

class ReorderState extends MainMenuState {
  const ReorderState(super.listTitle);
}

class MainReorderState extends MainMenuState {
  const MainReorderState(super.listTitle);
}

class MainDeleteState extends MainMenuState {
  final bool isPressed;
  final List<bool> isRedList;
  final List<String> newlistTask;
  const MainDeleteState({
    required this.isRedList,
    required this.isPressed,
    required this.newlistTask,
  }) : super(newlistTask);

  @override
  List<Object> get props => [isPressed, isRedList, newlistTask];
}

class MainDeleteProccessState extends MainMenuState {
  final bool isDelete;
  const MainDeleteProccessState(
    super.listTitle, {
    required this.isDelete,
  });
  @override
  List<Object?> get props => [isDelete];
}

class SaveState extends MainMenuState {
  const SaveState(super.listTitle);
}
