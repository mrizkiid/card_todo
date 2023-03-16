import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mainmenu_event.dart';
part 'mainmenu_state.dart';

class MainmenuBloc extends Bloc<MainmenuEvent, MainmenuState> {
  MainmenuBloc() : super(MainmenuInitial()) {
    on<MainmenuEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
