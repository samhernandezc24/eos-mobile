part of 'remote_inspeccion_categoria_bloc.dart';

sealed class RemoteInspeccionCategoriaEvent extends Equatable {
  const RemoteInspeccionCategoriaEvent();

  @override
  List<Object?> get props => [];
}

/// [GetPreguntasInspeccionCategoriaUseCase]
class GetInspeccionCategoriaPreguntas extends RemoteInspeccionCategoriaEvent {
  const GetInspeccionCategoriaPreguntas(this.objData);

  final InspeccionIdReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}