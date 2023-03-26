part of 'cubit_pressed_delete_cubit.dart';

abstract class CubitPressedDeleteState extends Equatable {
  const CubitPressedDeleteState();

  @override
  List<Object> get props => [];
}

class CubitPressedDeleteInitial extends CubitPressedDeleteState {}

class ChangeColor extends CubitPressedDeleteCubit {
  final bool isRed;

  ChangeColor({required this.isRed});
}
