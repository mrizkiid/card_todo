abstract class Failure {}

class ServerFailure extends Failure {
  String? errorMessage;
  ServerFailure({errorMessage});
}

class CacheFailure extends Failure {
  String? errorMessage;
  CacheFailure({errorMessage});
}
