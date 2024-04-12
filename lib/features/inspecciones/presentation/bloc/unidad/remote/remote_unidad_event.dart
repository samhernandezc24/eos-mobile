part of 'remote_unidad_bloc.dart';

sealed class RemoteUnidadEvent extends Equatable {
  const RemoteUnidadEvent();

  @override
  List<Object?> get props => [];
}

class CreateUnidad extends RemoteUnidadEvent {}

class StoreUnidad extends RemoteUnidadEvent {
  const StoreUnidad(this.unidad);

  final UnidadReqEntity unidad;

  @override
  List<Object?> get props => [ unidad ];
}
