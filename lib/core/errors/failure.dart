abstract class Failure {
  const Failure({required this.errorMessage});
  final String errorMessage;  
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
}

class CacheFailure extends Failure {
  CacheFailure({required super.errorMessage});
}
