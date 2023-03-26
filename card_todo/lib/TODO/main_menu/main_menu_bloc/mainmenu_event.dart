part of 'mainmenu_bloc.dart';

abstract class MainMenuEvent {
  const MainMenuEvent();
}

class MainActionEvent extends MainMenuEvent {
  const MainActionEvent();
}

class MainActionAdd extends MainMenuEvent {
  const MainActionAdd();
}

class MainReorderProcessData extends MainMenuEvent {
  const MainReorderProcessData(
      {required this.oldIndex, required this.newIndex});
  final int oldIndex;
  final int newIndex;

  // @override
  // List<Object?> get props => [oldIndex, newIndex];
}

class MainDelete extends MainMenuEvent {
  final bool isPressed;

  const MainDelete(this.isPressed);
}

class MainDeleteProcess extends MainMenuEvent {
  final int index;
  const MainDeleteProcess({required this.index});
}

class MainReorder extends MainMenuEvent {
  final bool isPressed;

  MainReorder(this.isPressed);
}

class InitialList extends MainMenuEvent {
  final List<String> listTitle;
  InitialList({required this.listTitle});
}

class MainSaveEvent extends MainMenuEvent {
  MainSaveEvent();
}

class MainDeleteSaveEvent extends MainMenuEvent {
  MainDeleteSaveEvent();
}
