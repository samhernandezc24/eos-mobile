part of 'remote_inspeccion_categoria_bloc.dart';

class RemoteInspeccionCategoriaState extends Equatable {
  const RemoteInspeccionCategoriaState();

  @override
  List<Object?> get props => [];
}

/// LOADING
class RemoteInspeccionCategoriaLoading extends RemoteInspeccionCategoriaState {}

/// GET PREGUNTAS
class RemoteInspeccionCategoriaGetPreguntasSuccess extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaGetPreguntasSuccess(this.objResponse);

  final InspeccionCategoriaChecklistEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteInspeccionCategoriaServerFailedMessage extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaServerFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteInspeccionCategoriaServerFailure extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaServerFailure(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
