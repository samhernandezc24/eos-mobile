part of 'remote_inspeccion_categoria_bloc.dart';

sealed class RemoteInspeccionCategoriaEvent extends Equatable {
  const RemoteInspeccionCategoriaEvent();

  @override
  List<Object?> get props => [];
}

/// [GetPreguntasInspeccionCategoriaUseCase]
class GetPreguntas extends RemoteInspeccionCategoriaEvent {
  const GetPreguntas(this.objData);

  final InspeccionIdReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [StoreInspeccionCategoriaUseCase]
class StoreInspeccionCategoria extends RemoteInspeccionCategoriaEvent {
  const StoreInspeccionCategoria(this.objData);

  final InspeccionCategoriaStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
