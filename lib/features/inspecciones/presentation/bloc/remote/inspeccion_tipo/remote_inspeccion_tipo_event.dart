part of 'remote_inspeccion_tipo_bloc.dart';

@immutable
abstract class RemoteInspeccionTipoEvent extends Equatable {
  const RemoteInspeccionTipoEvent();

  @override
  List<Object?> get props => [];
}

/// [RemoteListInspeccionTipoUseCase]
class ListInspeccionesTipos extends RemoteInspeccionTipoEvent {}

/// [RemoteStoreInspeccionTipoUseCase]
class StoreInspeccionTipo extends RemoteInspeccionTipoEvent {
  const StoreInspeccionTipo(this.objData);

  final InspeccionTipoStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemoteUpdateInspeccionTipoUseCase]
class UpdateInspeccionTipo extends RemoteInspeccionTipoEvent {
  const UpdateInspeccionTipo(this.objData);

  final InspeccionTipoEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemoteDeleteInspeccionTipoUseCase]
class DeleteInspeccionTipo extends RemoteInspeccionTipoEvent {
  const DeleteInspeccionTipo(this.objData);

  final InspeccionTipoIdParamEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
