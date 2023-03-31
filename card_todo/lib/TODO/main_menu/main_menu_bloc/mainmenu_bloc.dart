import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:card_todo/DATA/model/modelTodo.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/testfolder/hive/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'mainmenu_event.dart';
part 'mainmenu_state.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  List<TitleList> listTitle = [];
  List<int> indexDelete = [];
  String keyValue = '';
  String title = '';

  void changeToNewList(List<TitleList> listTileNew) {
    listTitle = [...listTileNew];
  }

  MainMenuBloc({required TodoData todoData})
      : super(const MainmenuInitial([])) {
    on<InitialListEvent>((event, emit) async {
      /////
      changeToNewList(await todoData.getTitleList);
      todoData.listTitle = listTitle;
      emit(MainmenuInitial(listTitle));
    });

    on<MainReorderEvent>((event, emit) {
      changeToNewList(state.listTitle);
      emit(MainReorderState(listTitle));
    });

    on<MainReorderProcessDataEvent>((event, emit) {
      changeToNewList(state.listTitle);
      int newIndex = event.newIndex;
      // remove and put in tile
      final TitleList tile = listTitle.removeAt(event.oldIndex);
      // place the tile in new position
      listTitle.insert(newIndex, tile);

      emit(MainReorderState(listTitle));
    });

    on<MainDeleteEvent>((event, emit) {
      changeToNewList(state.listTitle);
      bool isPressed = event.isPressed;
      emit(MainDeleteState(
          isRedList: List.filled(listTitle.length, false),
          isPressed: isPressed,
          newlistTask: listTitle));
    });

    on<MainDeleteProcessEvent>((event, emit) {
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

    on<MainReorderSaveEvent>((event, emit) {
      ///saving to list
      todoData.saveTitleList([...listTitle]);

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
      //move list to todoData
      todoData.saveTitleList([...listTitle]);

      changeToNewList(listTitle);
      emit(SaveState(listTitle));

      // deleteing list delete
      indexDelete = [];
    });
  }
}
