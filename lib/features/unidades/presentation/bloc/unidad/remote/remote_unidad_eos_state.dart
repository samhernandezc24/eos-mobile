part of 'remote_unidad_eos_bloc.dart';

class RemoteUnidadEOSState extends Equatable {
  const RemoteUnidadEOSState();

  @override
  List<Object?> get props => [];
}

/// INITIAL STATE
class RemoteUnidadEOSInitialState extends RemoteUnidadEOSState {}

/// PREDICTIVE
class RemoteUnidadEOSPredictiveLoading extends RemoteUnidadEOSState {}

class RemoteUnidadEOSPredictiveLoaded extends RemoteUnidadEOSState {
  const RemoteUnidadEOSPredictiveLoaded(this.objResponse);

  final List<UnidadEOSPredictiveListEntity>? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteUnidadEOSServerFailedMessagePredictive extends RemoteUnidadEOSState {
  const RemoteUnidadEOSServerFailedMessagePredictive(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteUnidadEOSServerFailurePredictive extends RemoteUnidadEOSState {
  const RemoteUnidadEOSServerFailurePredictive(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
