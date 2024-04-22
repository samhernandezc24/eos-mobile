part of 'remote_unidad_inventario_bloc.dart';

sealed class RemoteUnidadInventarioEvent extends Equatable {
  const RemoteUnidadInventarioEvent();

  @override
  List<Object?> get props => [];
}

class PredictiveUnidadInventario extends RemoteUnidadInventarioEvent {
  const PredictiveUnidadInventario(this.predictiveSearch);

  final PredictiveSearchReqEntity predictiveSearch;

  @override
  List<Object?> get props => [ predictiveSearch ];
}
