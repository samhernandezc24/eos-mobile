part of 'remote_inspeccion_tipo_bloc.dart';

sealed class RemoteInspeccionTipoEvent extends Equatable {
  const RemoteInspeccionTipoEvent();

  @override
  List<Object?> get props => [];
}

class ListInspeccionesTipos extends RemoteInspeccionTipoEvent {}

class StoreInspeccionTipo extends RemoteInspeccionTipoEvent {
  const StoreInspeccionTipo(this.data);

  final InspeccionTipoReqEntity data;

  @override
  List<Object?> get props => [ data ];
}
