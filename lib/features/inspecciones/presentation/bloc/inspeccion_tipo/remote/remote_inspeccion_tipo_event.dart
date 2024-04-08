part of 'remote_inspeccion_tipo_bloc.dart';

sealed class RemoteInspeccionTipoEvent extends Equatable {
  const RemoteInspeccionTipoEvent();

  @override
  List<Object?> get props => [];
}

class ListInspeccionesTipos extends RemoteInspeccionTipoEvent {}

class StoreInspeccionTipo extends RemoteInspeccionTipoEvent {
  const StoreInspeccionTipo(this.inspeccionTipo);

  final InspeccionTipoReqEntity inspeccionTipo;

  @override
  List<Object?> get props => [ inspeccionTipo ];
}

class UpdateInspeccionTipo extends RemoteInspeccionTipoEvent {
  const UpdateInspeccionTipo(this.inspeccionTipo);

  final InspeccionTipoEntity inspeccionTipo;

  @override
  List<Object?> get props => [ inspeccionTipo ];
}

class DeleteInspeccionTipo extends RemoteInspeccionTipoEvent {
  const DeleteInspeccionTipo(this.inspeccionTipo);

  final InspeccionTipoEntity inspeccionTipo;

  @override
  List<Object?> get props => [ inspeccionTipo ];
}
