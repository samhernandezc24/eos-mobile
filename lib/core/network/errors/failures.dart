import 'package:eos_mobile/shared/shared.dart';

abstract class Failure extends Equatable {
  const Failure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// ERRORES DE SERVIDOR
class ServerFailure extends Failure {
  const ServerFailure({required String errorMessage, this.statusCode}) : super(errorMessage: errorMessage);

  final int? statusCode;
}

/// ERRORES LOCALES
class LocalFailure extends Failure {
  const LocalFailure({required String errorMessage, this.statusCode}) : super(errorMessage: errorMessage);

  final int? statusCode;
}
