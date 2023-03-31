part of 'mainmenu_bloc.dart';

abstract class MainMenuEvent {
  const MainMenuEvent();
}

class InitialListEvent extends MainMenuEvent {
  String? title;
  String? keyValue;
  InitialListEvent({this.title, this.keyValue});
}

class MainActionEvent extends MainMenuEvent {
  const MainActionEvent();
}

class MainActionAddEvent extends MainMenuEvent {
  const MainActionAddEvent();
}

class MainReorderProcessDataEvent extends MainMenuEvent {
  const MainReorderProcessDataEvent(
      {required this.oldIndex, required this.newIndex});
  final int oldIndex;
  final int newIndex;

  // @override
  // List<Object?> get props => [oldIndex, newIndex];
}

class MainDeleteEvent extends MainMenuEvent {
  final bool isPressed;

  const MainDeleteEvent(this.isPressed);
}

class MainDeleteProcessEvent extends MainMenuEvent {
  final int index;
  const MainDeleteProcessEvent({required this.index});
}

class MainReorderEvent extends MainMenuEvent {
  final bool isPressed;

  MainReorderEvent(this.isPressed);
}

class MainReorderSaveEvent extends MainMenuEvent {
  MainReorderSaveEvent();
}

class MainDeleteSaveEvent extends MainMenuEvent {
  MainDeleteSaveEvent();
}
