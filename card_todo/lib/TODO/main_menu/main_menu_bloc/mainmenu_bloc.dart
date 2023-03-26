import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:equatable/equatable.dart';

part 'mainmenu_event.dart';
part 'mainmenu_state.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  List<String> listTitle = [];
  List<int> indexDelete = [];

  void changeToNewList(List<String> listTileNew) {
    listTitle = [...listTileNew];
  }

  MainMenuBloc({required TodoData todoData})
      : super(const MainmenuInitial([])) {
    on<InitialList>((event, emit) {
      // listTitle = [...event.listTitle];
      changeToNewList(event.listTitle);
      emit(MainmenuInitial(listTitle));
    });

    on<MainReorder>((event, emit) {
      changeToNewList(state.listTitle);
      emit(MainReorderState(listTitle));
    });

    on<MainReorderProcessData>((event, emit) {
      changeToNewList(state.listTitle);
      int newIndex = event.newIndex;
      // remove and put in tile
      final String tile = listTitle.removeAt(event.oldIndex);
      // place the tile in new position
      listTitle.insert(newIndex, tile);

      emit(MainReorderState(listTitle));
    });

    on<MainDelete>((event, emit) {
      changeToNewList(state.listTitle);
      bool isPressed = event.isPressed;
      emit(MainDeleteState(
          isRedList: List.filled(listTitle.length, false),
          isPressed: isPressed,
          newlistTask: listTitle));
    });

    on<MainDeleteProcess>((event, emit) {
      List<bool> isRedList = [];
      if (state is MainDeleteState) {
        final currentState = state as MainDeleteState;
        //make new list isRedList
        isRedList = [...currentState.isRedList];
        //changing isRedList value
        isRedList[event.index] = !isRedList[event.index];
      }

      /// this adding to list index , it will do delete in last when
      /// do saving event
      indexDelete.add(event.index);

      //changing listTitle to new list
      changeToNewList(state.listTitle);
      bool isPressed = true;
      emit(MainDeleteState(
          isRedList: isRedList, isPressed: isPressed, newlistTask: listTitle));
    });

    on<MainSaveEvent>((event, emit) {
      ///saving to list
      todoData.listTitle = [...listTitle];

      //emitting listTile to new List
      changeToNewList(state.listTitle);
      emit(SaveState(listTitle));
    });

    on<MainDeleteSaveEvent>((event, emit) {
      listTitle = state.listTitle;
      if (indexDelete.isNotEmpty) {
        indexDelete.sort(
          (a, b) => b.compareTo(a),
        );
        for (int i in indexDelete) {
          listTitle.removeAt(i);
        }
      }

      changeToNewList(listTitle);

      emit(SaveState(listTitle));
    });
  }
}
