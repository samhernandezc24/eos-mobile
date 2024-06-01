part of 'remote_inspeccion_categoria_bloc.dart';

class RemoteInspeccionCategoriaState extends Equatable {
  const RemoteInspeccionCategoriaState();

  @override
  List<Object?> get props => [];
}

/// INITIAL STATE
class RemoteInspeccionCategoriaInitial extends RemoteInspeccionCategoriaState {}

/// GET PREGUNTAS
class RemoteInspeccionCategoriaGetPreguntasLoading extends RemoteInspeccionCategoriaState {}

class RemoteInspeccionCategoriaGetPreguntasSuccess extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaGetPreguntasSuccess(this.objResponse);

  final InspeccionCategoriaChecklistEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE
class RemoteInspeccionCategoriaStoring extends RemoteInspeccionCategoriaState {}

class RemoteInspeccionCategoriaStored extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaStored(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteInspeccionCategoriaServerFailedMessageGetPreguntas extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaServerFailedMessageGetPreguntas(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteInspeccionCategoriaServerFailedMessageStore extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaServerFailedMessageStore(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteInspeccionCategoriaServerFailureGetPreguntas extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaServerFailureGetPreguntas(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteInspeccionCategoriaServerFailureStore extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaServerFailureStore(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
