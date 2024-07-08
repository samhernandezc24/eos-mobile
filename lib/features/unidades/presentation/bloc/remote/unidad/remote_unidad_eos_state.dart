part of 'remote_unidad_eos_bloc.dart';

@immutable
abstract class RemoteUnidadEOSState extends Equatable {
  const RemoteUnidadEOSState();

  @override
  List<Object?> get props => [];
}

/// INIT
class RemoteUnidadEOSInit extends RemoteUnidadEOSState {}

/// PREDICTIVE
class RemoteUnidadEOSPredictiveLoading extends RemoteUnidadEOSState {}

class RemoteUnidadEOSPredictive extends RemoteUnidadEOSState {
  const RemoteUnidadEOSPredictive(this.objResponse);

  final List<UnidadEOSPredictiveEntity>? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteUnidadEOSServerFailedMessagePredictive extends RemoteUnidadEOSState {
  const RemoteUnidadEOSServerFailedMessagePredictive(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

/// SERVER EXCEPTION
class RemoteUnidadEOSServerExceptionMessagePredictive extends RemoteUnidadEOSState {
  const RemoteUnidadEOSServerExceptionMessagePredictive(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}
