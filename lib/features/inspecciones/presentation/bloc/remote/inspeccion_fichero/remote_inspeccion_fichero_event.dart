part of 'remote_inspeccion_fichero_bloc.dart';

@immutable
abstract class RemoteInspeccionFicheroEvent extends Equatable {
  const RemoteInspeccionFicheroEvent();

  @override
  List<Object?> get props => [];
}

/// [RemoteListInspeccionFicheroUseCase]
class ListFicheros extends RemoteInspeccionFicheroEvent {
  const ListFicheros(this.objData);

  final InspeccionIdParamEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemoteStoreInspeccionFicheroUseCase]
class StoreInspeccionFichero extends RemoteInspeccionFicheroEvent {
  const StoreInspeccionFichero(this.objData);

  final InspeccionFicheroStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemoteDeleteInspeccionFicheroUseCase]
class DeleteInspeccionFichero extends RemoteInspeccionFicheroEvent {
  const DeleteInspeccionFichero(this.objData);

  final InspeccionFicheroIdParamEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
