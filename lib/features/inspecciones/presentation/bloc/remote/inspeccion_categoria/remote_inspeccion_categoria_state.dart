part of 'remote_inspeccion_categoria_bloc.dart';

@immutable
abstract class RemoteInspeccionCategoriaState extends Equatable {
  const RemoteInspeccionCategoriaState();

  @override
  List<Object?> get props => [];
}

/// INIT
class RemoteInspeccionCategoriaInit extends RemoteInspeccionCategoriaState {}

/// GET PREGUNTAS
class RemoteInspeccionCategoriaGetPreguntasLoading extends RemoteInspeccionCategoriaState {}

class RemoteInspeccionCategoriaGetPreguntas extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaGetPreguntas(this.objResponse);

  final InspeccionCategoriaChecklistEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE
class RemoteInspeccionCategoriaStoreLoading extends RemoteInspeccionCategoriaState {}

class RemoteInspeccionCategoriaStore extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaStore(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteInspeccionCategoriaServerFailedMessageGetPreguntas extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaServerFailedMessageGetPreguntas(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionCategoriaServerFailedMessageStore extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaServerFailedMessageStore(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

/// SERVER EXCEPTION
class RemoteInspeccionCategoriaServerExceptionMessageGetPreguntas extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaServerExceptionMessageGetPreguntas(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionCategoriaServerExceptionMessageStore extends RemoteInspeccionCategoriaState {
  const RemoteInspeccionCategoriaServerExceptionMessageStore(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}
