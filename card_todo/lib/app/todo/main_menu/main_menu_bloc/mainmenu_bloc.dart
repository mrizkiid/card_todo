import 'package:bloc/bloc.dart';
import 'package:card_todo/utils/widget/button_floating_action/bloc_button/button_animation_bloc.dart';
import 'package:card_todo/data/model/modelTodo.dart';
import 'package:card_todo/data/model/model_user.dart';
import 'package:card_todo/domain/repositories/todo_repo.dart';
import 'package:equatable/equatable.dart';

part 'mainmenu_event.dart';
part 'mainmenu_state.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  List<TitleList> _listTitle = [];
  List<int> _indexDelete = [];
  String _keyValue = '';
  // String _title = '';
  String _lastKey = '';
  String _username = '';
  // int _sumTask = 0;
  bool isButtonCalled = true;
  late ButtonAnimationBloc buttonAnimationBloc;

  void changeToNewList(List<TitleList> listTileNew) {
    _listTitle = [...listTileNew];
  }

  int takeIntFromKey(String keyValue) {
    int numberKey = int.parse(_lastKey.substring(1));
    return numberKey;
  }

  void initBloc(ButtonAnimationBloc input) {
    buttonAnimationBloc = input;
  }

  void deleteCancel() {
    _indexDelete = [];
  }

  void emptyOrNotEmptyList() {
    if (_listTitle.isEmpty && isButtonCalled == true) {
      isButtonCalled = false;
      buttonAnimationBloc.add(ButtonEmptyEvent());
    }
    if (_listTitle.isNotEmpty && isButtonCalled == false) {
      isButtonCalled = true;
      buttonAnimationBloc.add(ButtonActionAdd());
    }
  }

  MainMenuBloc({
    required TodoRepository todoRepo,
    required UserModel userModel,
  }) : super(const MainmenuInitial([])) {
    on<InitialService>((event, emit) async {
      emit(MainLoadingState([...state.listTitle]));
      final dataState = await todoRepo.init();
      dataState.when(
        success: (data) => add(InitialListEvent()),
        error: (failure) => emit(MainFailedState(state.listTitle)),
      );
    });

    on<InitialListEvent>((event, emit) async {
      // get data from hive and put the value to _listTitle

      final dataState = await todoRepo.getTitleList();
      dataState.when(
        success: (data) => changeToNewList(data ?? state.listTitle),
        error: (failure) => emit(MainFailedState(state.listTitle)),
      );

      final dataStateFindLastKey = await todoRepo.findLastKey();
      dataStateFindLastKey.when(
        success: (data) => {
          if (data != null) {_lastKey = data}
        },
        error: (failure) => emit(MainFailedState(state.listTitle)),
      );
      _username = userModel.username;

      //event blocButton
      emptyOrNotEmptyList();

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

    on<MainDeleteSaveEvent>((event, emit) async {
      emit(MainLoadingState(state.listTitle));
      _listTitle = state.listTitle;
      if (_indexDelete.isNotEmpty) {
        _indexDelete.sort(
          (a, b) => b.compareTo(a),
        );
        for (int i in _indexDelete) {
          final dataState =
              await todoRepo.deleteTaskList(keyValue: _listTitle[i].keyValue);
          dataState.when(
            success: (data) => {},
            error: (failure) {
              emit(MainFailedState(state.listTitle));
              return;
            },
          );
          _listTitle.removeAt(i);
        }
      }

      //move list to todoData
      final dataState = await todoRepo.saveTitleList([..._listTitle]);
      dataState.when(
        success: (data) => {},
        error: ((failure) {
          emit(MainFailedState(state.listTitle));
          return;
        }),
      );

      changeToNewList(_listTitle);

      //event blocButton
      emptyOrNotEmptyList();

      emit(SaveState(_listTitle));

      // deleteing list delete
      _indexDelete = [];
    });

    on<MainMenuAddEvent>((event, emit) async {
      emit(MainLoadingState(state.listTitle));

      /// create keyValue
      final dataState = await todoRepo.findLastKey();
      dataState.when(
        success: (data) => {
          if (data != null) {_lastKey = data}
        },
        error: (failure) {
          emit(MainFailedState(state.listTitle));
          return;
        },
      );
      int numberKey = takeIntFromKey(_lastKey);
      numberKey = numberKey + 1;
      _keyValue = 't$numberKey';

      /// save lastKey in to hive
      final dataStateSaveLastKey = await todoRepo.saveLastKey(_keyValue);
      dataStateSaveLastKey.when(
        success: (data) => {},
        error: (failure) {
          emit(MainFailedState(state.listTitle));
          return;
        },
      );

      _listTitle.add(TitleList(
          title: event.titleTask,
          keyValue: _keyValue,
          sumTask: 0,
          username: _username));

      // todoData.listTitle = _listTitle;

      /// cange list to new list
      changeToNewList(_listTitle);

      //event blocButton
      emptyOrNotEmptyList();

      /// save listTitle in to Hive
      final dataStateSaveTitleList = await todoRepo.saveTitleList(_listTitle);
      dataStateSaveTitleList.when(
        success: (data) => {},
        error: (failure) {
          emit(MainFailedState(state.listTitle));
          return;
        },
      );

      final dataStateSaveTaskList = await todoRepo.saveTaskList(
          keyValue: _keyValue, title: event.titleTask, taskList: <TaskList>[]);
      dataStateSaveTaskList.when(
        success: (data) => emit(SaveState(_listTitle)),
        error: (failure) {
          emit(MainFailedState(state.listTitle));
          return;
        },
      );
    });

    on<MainReorderSaveEvent>((event, emit) async {
      ///saving to list
      final dataState = await todoRepo.saveTitleList([..._listTitle]);
      dataState.when(
        success: (data) => {
          //emitting listTile to new List
          changeToNewList(state.listTitle),
          emit(SaveState(_listTitle)),
        },
        error: (failure) {
          emit(MainFailedState(state.listTitle));
          return;
        },
      );
    });
  }
}
