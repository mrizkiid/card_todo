part of 'mainmenu_bloc.dart';

abstract class MainmenuEvent {
  const MainmenuEvent();
}

class ActionEvent extends MainmenuEvent {
  const ActionEvent();
}

class ActionAdd extends MainmenuEvent {
  const ActionAdd();
}

class ActionReorder extends MainmenuEvent {
  const ActionReorder();
}

class ActionDelete extends MainmenuEvent {
  const ActionDelete();
}
