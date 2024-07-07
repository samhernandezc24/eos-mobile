part of 'remote_unidad_bloc.dart';

@immutable
abstract class RemoteUnidadEvent extends Equatable {
  const RemoteUnidadEvent();

  @override
  List<Object?> get props => [];
}

/// [RemoteCreateUnidadUseCase]
class CreateUnidad extends RemoteUnidadEvent {}

/// [RemoteStoreUnidadUseCase]
class StoreUnidad extends RemoteUnidadEvent {
  const StoreUnidad(this.objData);

  final UnidadStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemotePredictiveUnidadUseCase]
class PredictiveUnidades extends RemoteUnidadEvent {
  const PredictiveUnidades(this.varArgs);

  final Predictive varArgs;

  @override
  List<Object?> get props => [ varArgs ];
}
