import 'package:card_todo/core/error/failures.dart';

class ServerFailure extends Failure {
  String? errorMessage;
  ServerFailure({this.errorMessage});
}
