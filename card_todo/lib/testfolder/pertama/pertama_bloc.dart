import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pertama_event.dart';
part 'pertama_state.dart';

class PertamaBloc extends Bloc<PertamaEvent, PertamaState> {
  PertamaBloc() : super(PertamaInitial()) {
    on<PertamaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
