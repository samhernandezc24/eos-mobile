part of 'remote_inspeccion_categoria_bloc.dart';

@immutable
abstract class RemoteInspeccionCategoriaEvent extends Equatable {
  const RemoteInspeccionCategoriaEvent();

  @override
  List<Object?> get props => [];
}

/// [RemoteGetPreguntasInspeccionCategoriaUseCase]
class GetPreguntas extends RemoteInspeccionCategoriaEvent {
  const GetPreguntas(this.objData);

  final InspeccionIdParamEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemoteStoreInspeccionCategoriaUseCase]
class StoreInspeccionCategoria extends RemoteInspeccionCategoriaEvent {
  const StoreInspeccionCategoria(this.objData);

  final InspeccionCategoriaStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
