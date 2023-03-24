part of 'mainmenu_bloc.dart';

abstract class MainmenuEvent {
  const MainmenuEvent();
}

class MainActionEvent extends MainmenuEvent {
  const MainActionEvent();
}

class MainActionAdd extends MainmenuEvent {
  const MainActionAdd();
}

class MainReorderProcessData extends MainmenuEvent {
  const MainReorderProcessData(
      {required this.oldIndex, required this.newIndex});
  final int oldIndex;
  final int newIndex;

  // @override
  // List<Object?> get props => [oldIndex, newIndex];
}

class MainActionDeleteButton extends MainmenuEvent {
  final bool isPressed;

  MainActionDeleteButton(this.isPressed);
}

class MainActionReorderButton extends MainmenuEvent {
  final bool isPressed;

  MainActionReorderButton(this.isPressed);
}

class InitialList extends MainmenuEvent {
  final List<String> listTitle;
  InitialList({required this.listTitle});
}

class MainSaveEvent extends MainmenuEvent {
  List<String> listTitle;

  MainSaveEvent({required this.listTitle});
}
