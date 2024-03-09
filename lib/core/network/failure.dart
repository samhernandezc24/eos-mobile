abstract class Failure {
  const Failure({required this.errorMessage});
  final String errorMessage;
}

class ServerFailure extends Failure {
  ServerFailure({required String errorMessage}) : super(errorMessage: errorMessage);
}

class CacheFailure extends Failure {
  CacheFailure({required String errorMessage}) : super(errorMessage: errorMessage);
}
