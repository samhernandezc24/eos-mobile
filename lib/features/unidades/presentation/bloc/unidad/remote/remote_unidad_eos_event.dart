part of 'remote_unidad_eos_bloc.dart';

sealed class RemoteUnidadEOSEvent extends Equatable {
  const RemoteUnidadEOSEvent();

  @override
  List<Object?> get props => [];
}

/// [PredictiveEOSUnidadUseCase]
class PredictiveEOSUnidades extends RemoteUnidadEOSEvent {
  const PredictiveEOSUnidades(this.varArgs);

  final Predictive varArgs;

  @override
  List<Object?> get props => [ varArgs ];
}
