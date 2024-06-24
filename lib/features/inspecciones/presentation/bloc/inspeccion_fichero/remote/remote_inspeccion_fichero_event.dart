part of 'remote_inspeccion_fichero_bloc.dart';

sealed class RemoteInspeccionFicheroEvent extends Equatable {
  const RemoteInspeccionFicheroEvent();

  @override
  List<Object?> get props => [];
}

/// [ListInspeccionFicheroUseCase]
class ListInspeccionFicheros extends RemoteInspeccionFicheroEvent {
  const ListInspeccionFicheros(this.objData);

  final InspeccionIdReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [StoreInspeccionFicheroUseCase]
class StoreInspeccionFichero extends RemoteInspeccionFicheroEvent {
  const StoreInspeccionFichero(this.objData);

  final InspeccionFicheroStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [DeleteInspeccionFicheroUseCase]
class DeleteInspeccionFichero extends RemoteInspeccionFicheroEvent {
  const DeleteInspeccionFichero(this.objData);

  final InspeccionFicheroIdReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
