import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:card_todo/DATA/model/modelTodo.dart';
import 'package:card_todo/DATA/model/modelUser.dart';
import 'package:card_todo/DATA/provider/todo_data.dart';
import 'package:card_todo/testfolder/hive/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'mainmenu_event.dart';
part 'mainmenu_state.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  List<TitleList> _listTitle = [];
  List<int> _indexDelete = [];
  String _keyValue = '';
  // String _title = '';
  String _lastKey = '';
  String _username = '';

  void changeToNewList(List<TitleList> listTileNew) {
    _listTitle = [...listTileNew];
  }

  int takeIntFromKey(String keyValue) {
    int numberKey = int.parse(_lastKey.substring(1));
    return numberKey;
  }

  MainMenuBloc({required TodoData todoData, required UserModel userModel})
      : super(const MainmenuInitial([])) {
    on<InitialService>((event, emit) async {
      await todoData.init();
    });

    on<InitialListEvent>((event, emit) async {
      emit(MainLoadingState(const []));
      // get data from hive and put the value to _listTitle
      changeToNewList(await todoData.getTitleList);
      _lastKey = await todoData.findLastKey;
      _username = await userModel.username;
      todoData.listTitle = _listTitle;
      todoData.lastKey = _lastKey;
      emit(MainmenuInitial(_listTitle));
    });

    on<MainReorderEvent>((event, emit) {
      changeToNewList(state.listTitle);
      emit(MainReorderState(_listTitle));
    });

    on<MainReorderProcessDataEvent>((event, emit) {
      changeToNewList(state.listTitle);
      int newIndex = event.newIndex;
      // remove and put in tile
      final TitleList tile = _listTitle.removeAt(event.oldIndex);
      // place the tile in new position
      _listTitle.insert(newIndex, tile);

      emit(MainReorderState(_listTitle));
    });

    on<MainDeleteEvent>((event, emit) {
      changeToNewList(state.listTitle);
      bool isPressed = event.isPressed;
      emit(MainDeleteState(
          isRedList: List.filled(_listTitle.length, false),
          isPressed: isPressed,
          newlistTask: _listTitle));
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
      _indexDelete.add(event.index);
      changeToNewList(state.listTitle);
      bool isPressed = true;
      emit(MainDeleteState(
          isRedList: isRedList, isPressed: isPressed, newlistTask: _listTitle));
    });

    on<MainMenuAddEvent>((event, emit) async {
      emit(MainLoadingState(const []));

      /// create keyValue
      int numberKey = takeIntFromKey(_lastKey);
      numberKey = numberKey + 1;
      _keyValue = 't$numberKey';

      /// save lastKey in to hive
      await todoData.saveLastKey(_keyValue);

      todoData.listTitle.add(TitleList(
          title: event.titleTask,
          keyValue: _keyValue,
          sumTask: 0,
          username: _username));

      /// cange list to new list
      changeToNewList(_listTitle);

      /// save listTitle in to Hive
      await todoData.saveTitleList(_listTitle);
      emit(SaveState(_listTitle));
    });

    on<MainReorderSaveEvent>((event, emit) {
      ///saving to list
      todoData.saveTitleList([..._listTitle]);

      //emitting listTile to new List
      changeToNewList(state.listTitle);
      emit(SaveState(_listTitle));
    });

    on<MainDeleteSaveEvent>((event, emit) {
      emit(MainLoadingState(const []));
      _listTitle = state.listTitle;
      if (_indexDelete.isNotEmpty) {
        _indexDelete.sort(
          (a, b) => b.compareTo(a),
        );
        for (int i in _indexDelete) {
          _listTitle.removeAt(i);
        }
      }
      //move list to todoData
      todoData.saveTitleList([..._listTitle]);

      changeToNewList(_listTitle);
      emit(SaveState(_listTitle));

      // deleteing list delete
      _indexDelete = [];
    });
  }
}
