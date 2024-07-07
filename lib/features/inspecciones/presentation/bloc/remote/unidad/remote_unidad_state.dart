part of 'remote_unidad_bloc.dart';

@immutable
abstract class RemoteUnidadState extends Equatable {
  const RemoteUnidadState();

  @override
  List<Object?> get props => [];
}

/// INIT
class RemoteUnidadInit extends RemoteUnidadState {}

/// LOADING
class RemoteUnidadLoading extends RemoteUnidadState {}

/// CREATE
class RemoteUnidadCreateLoading extends RemoteUnidadState {}

class RemoteUnidadCreate extends RemoteUnidadState {
  const RemoteUnidadCreate(this.objResponse);

  final UnidadCreateEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE
class RemoteUnidadStoreLoading extends RemoteUnidadState {}

class RemoteUnidadStore extends RemoteUnidadState {
  const RemoteUnidadStore(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// PREDICTIVE
class RemoteUnidadPredictiveLoading extends RemoteUnidadState {}

class RemoteUnidadPredictive extends RemoteUnidadState {
  const RemoteUnidadPredictive(this.objResponse);

  final List<UnidadPredictiveEntity>? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteUnidadServerFailedMessageCreate extends RemoteUnidadState {
  const RemoteUnidadServerFailedMessageCreate(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteUnidadServerFailedMessageStore extends RemoteUnidadState {
  const RemoteUnidadServerFailedMessageStore(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteUnidadServerFailedMessagePredictive extends RemoteUnidadState {
  const RemoteUnidadServerFailedMessagePredictive(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

/// SERVER EXCEPTION
class RemoteUnidadServerExceptionMessageCreate extends RemoteUnidadState {
  const RemoteUnidadServerExceptionMessageCreate(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteUnidadServerExceptionMessageStore extends RemoteUnidadState {
  const RemoteUnidadServerExceptionMessageStore(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteUnidadServerExceptionMessagePredictive extends RemoteUnidadState {
  const RemoteUnidadServerExceptionMessagePredictive(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}
