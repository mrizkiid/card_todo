import 'package:equatable/equatable.dart';

class xy extends Equatable {
  xy(this.y);
  List y;
  @override
  List<Object?> get props => [
        y,
      ];
}

class ab extends Equatable {
  ab(this.x);
  List x;

  @override
  // TODO: implement props
  List<Object?> get props => [x];
}

void main() {}
