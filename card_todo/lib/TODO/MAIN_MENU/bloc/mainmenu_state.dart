part of 'mainmenu_bloc.dart';

abstract class MainmenuState extends Equatable {
  const MainmenuState();

  @override
  List<Object> get props => [];
}

class MainmenuInitial extends MainmenuState {}

class ReorderState extends MainmenuState {}

class DeleteState extends MainmenuState {}
