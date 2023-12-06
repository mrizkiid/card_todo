import 'package:card_todo/core/error/failures.dart';

class FirebaseFailure extends Failure {
  const FirebaseFailure({this.messageError});

  final String? messageError;
}
