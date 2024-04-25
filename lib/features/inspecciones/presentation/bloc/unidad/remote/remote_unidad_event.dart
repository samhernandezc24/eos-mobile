part of 'remote_unidad_bloc.dart';

sealed class RemoteUnidadEvent extends Equatable {
  const RemoteUnidadEvent();

  @override
  List<Object?> get props => [];
}

class CreateUnidad extends RemoteUnidadEvent {}

class LoadBases extends RemoteUnidadEvent {}
class LoadUnidadesMarcas extends RemoteUnidadEvent {}
class LoadUnidadesTipos extends RemoteUnidadEvent {}

class PredictiveUnidad extends RemoteUnidadEvent {
  const PredictiveUnidad(this.predictiveSearch);

  final PredictiveSearchReqEntity predictiveSearch;

  @override
  List<Object?> get props => [ predictiveSearch ];
}

class StoreUnidad extends RemoteUnidadEvent {
  const StoreUnidad(this.unidad);

  final UnidadReqEntity unidad;

  @override
  List<Object?> get props => [ unidad ];
}
