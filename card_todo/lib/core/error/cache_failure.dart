import 'package:card_todo/core/error/failures.dart';

class CacheFailure extends Failure {
  final String? errorMessage;
  const CacheFailure({this.errorMessage});
}
