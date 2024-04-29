import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

/// SERVER ERRORS
class ServerFailure extends Failure {
  const ServerFailure({required this.dataFailed});

  final DataFailed<DioException> dataFailed;

  @override
  List<Object?> get props => [ dataFailed ];
}

/// LOCAL ERRORS
class LocalFailure extends Failure {
  const LocalFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}
