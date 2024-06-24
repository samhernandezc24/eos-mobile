part of 'remote_unidad_bloc.dart';

sealed class RemoteUnidadEvent extends Equatable {
  const RemoteUnidadEvent();

  @override
  List<Object?> get props => [];
}

/// [IndexUnidadUseCase]
class FetchUnidadInit extends RemoteUnidadEvent {}

/// [DataSourceUnidadUseCase]
class FetchUnidadDataSource extends RemoteUnidadEvent {
  const FetchUnidadDataSource(this.objData);

  final Map<String, dynamic> objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [CreateUnidadUseCase]
class FetchUnidadCreate extends RemoteUnidadEvent {}

/// [StoreUnidadUseCase]
class StoreUnidad extends RemoteUnidadEvent {
  const StoreUnidad(this.objData);

  final UnidadStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [ListUnidadUseCase]
class ListUnidades extends RemoteUnidadEvent {}

/// [PredictiveUnidadUseCase]
class PredictiveUnidades extends RemoteUnidadEvent {
  const PredictiveUnidades(this.varArgs);

  final Predictive varArgs;

  @override
  List<Object?> get props => [ varArgs ];
}
