part of 'remote_inspeccion_tipo_bloc.dart';

sealed class RemoteInspeccionTipoEvent extends Equatable {
  const RemoteInspeccionTipoEvent();

  @override
  List<Object?> get props => [];
}

/// [ListInspeccionTipoUseCase]
class ListInspeccionesTipos extends RemoteInspeccionTipoEvent {}

/// [StoreInspeccionTipoUseCase]
class StoreInspeccionTipo extends RemoteInspeccionTipoEvent {
  const StoreInspeccionTipo(this.objData);

  final InspeccionTipoStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [UpdateInspeccionTipoUseCase]
class UpdateInspeccionTipo extends RemoteInspeccionTipoEvent {
  const UpdateInspeccionTipo(this.objData);

  final InspeccionTipoEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [DeleteInspeccionTipoUseCase]
class DeleteInspeccionTipo extends RemoteInspeccionTipoEvent {
  const DeleteInspeccionTipo(this.objData);

  final InspeccionTipoEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
