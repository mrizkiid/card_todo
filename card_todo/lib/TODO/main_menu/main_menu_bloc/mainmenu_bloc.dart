import 'package:bloc/bloc.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:equatable/equatable.dart';

part 'mainmenu_event.dart';
part 'mainmenu_state.dart';

class MainMenuBloc extends Bloc<MainmenuEvent, MainMenuState> {
  List<String> listTitle = [];
  MainMenuBloc({required TodoData todoData})
      : super(const MainmenuInitial([])) {
    on<InitialList>((event, emit) {
      listTitle = [...event.listTitle];
      emit(MainmenuInitial(listTitle));
    });

    on<MainReorderProcessData>((event, emit) {
      int newIndex = event.newIndex;
      // listTitle = listTitle;

      // if (event.oldIndex < event.newIndex) {
      //   newIndex -= 1;
      // }

      // remove and put in tile
      final String tile = listTitle.removeAt(event.oldIndex);
      // place the tile in new position
      listTitle.insert(newIndex, tile);

      emit(MainReorderProcessDataState(listTitle));
    });

    on<MainActionDeleteButton>((event, emit) {
      bool isPressed = event.isPressed;
      emit(MainDeleteButtonState(isPressed, listTitle));
    });

    on<MainActionReorderButton>((event, emit) {
      // bool isPressed = event.isPressed;
      emit(MainReorderButtonState(listTitle));
    });

    on<MainSaveEvent>((event, emit) {
      todoData.listTitle = [...state.listTitle];
      emit(SaveState(listTitle));
    });
  }
}
