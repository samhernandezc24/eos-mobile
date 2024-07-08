part of 'remote_unidad_eos_bloc.dart';

@immutable
abstract class RemoteUnidadEOSEvent extends Equatable {
  const RemoteUnidadEOSEvent();

  @override
  List<Object?> get props => [];
}

/// [RemotePredictiveEOSUnidadUseCase]
class PredictiveUnidadesEOS extends RemoteUnidadEOSEvent {
  const PredictiveUnidadesEOS(this.varArgs);

  final Predictive varArgs;

  @override
  List<Object?> get props => [ varArgs ];
}
