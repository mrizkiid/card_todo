part of 'mainmenu_bloc.dart';

abstract class MainMenuState {
  const MainMenuState(this.listTitle);

  final List<String> listTitle;
}

class MainmenuInitial extends MainMenuState {
  const MainmenuInitial(super.listTitle);
}

class ReorderState extends MainMenuState {
  const ReorderState(super.listTitle);
}

class MainReorderProcessDataState extends MainMenuState {
  MainReorderProcessDataState(super.listTitle);
  // final List<String> newlistTitle;

  // const MainReorderProcessDataState({required this.newlistTitle})
  //     : super(newlistTitle);
}

class MainReorderButtonState extends MainMenuState {
  // final List<String> newlistTitle;
  // final bool isPressed;

  // const MainReorderButtonState(this.isPressed, this.newlistTitle)
  //     : super(newlistTitle);
  const MainReorderButtonState(super.listTitle);

  // @override
  // List<Object> get props => [isPressed];
}

class MainDeleteButtonState extends MainMenuState {
  final bool isPressed;
  final List<String> newlistTask;
  const MainDeleteButtonState(this.isPressed, this.newlistTask)
      : super(newlistTask);

  @override
  List<Object> get props => [isPressed];
}

class SaveState extends MainMenuState {
  SaveState(super.listTitle);
}
