part of 'remote_unidad_bloc.dart';

class RemoteUnidadState extends Equatable {
  const RemoteUnidadState();

  @override
  List<Object?> get props => [];
}

/// INITIAL STATE
class RemoteUnidadInitialState extends RemoteUnidadState {}

/// INITIALIZATION
class RemoteUnidadLoading extends RemoteUnidadState {}

class RemoteUnidadInitialization extends RemoteUnidadState {
  const RemoteUnidadInitialization(this.objResponse);

  final UnidadIndexEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DATASOURCE
class RemoteUnidadDataSourceLoaded extends RemoteUnidadState {
  const RemoteUnidadDataSourceLoaded(this.objResponse);

  final UnidadDataSourceResEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// CREATE
class RemoteUnidadCreateLoading extends RemoteUnidadState {}

class RemoteUnidadCreateLoaded extends RemoteUnidadState {
  const RemoteUnidadCreateLoaded(this.objResponse);

  final UnidadCreateEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE
class RemoteUnidadStoreLoading extends RemoteUnidadState {}

class RemoteUnidadStoreSuccess extends RemoteUnidadState {
  const RemoteUnidadStoreSuccess(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// LIST
class RemoteUnidadListLoading extends RemoteUnidadState {}

class RemoteUnidadListLoaded extends RemoteUnidadState {
  const RemoteUnidadListLoaded(this.objResponse);

  final List<UnidadEntity>? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// PREDICTIVE
class RemoteUnidadPredictiveLoading extends RemoteUnidadState {}

class RemoteUnidadPredictiveLoaded extends RemoteUnidadState {
  const RemoteUnidadPredictiveLoaded(this.objResponse);

  final List<UnidadPredictiveListEntity>? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteUnidadServerFailedMessage extends RemoteUnidadState {
  const RemoteUnidadServerFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteUnidadServerFailedMessageCreate extends RemoteUnidadState {
  const RemoteUnidadServerFailedMessageCreate(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteUnidadServerFailedMessageStore extends RemoteUnidadState {
  const RemoteUnidadServerFailedMessageStore(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteUnidadServerFailedMessageList extends RemoteUnidadState {
  const RemoteUnidadServerFailedMessageList(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteUnidadServerFailedMessagePredictive extends RemoteUnidadState {
  const RemoteUnidadServerFailedMessagePredictive(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteUnidadServerFailure extends RemoteUnidadState {
  const RemoteUnidadServerFailure(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteUnidadServerFailureCreate extends RemoteUnidadState {
  const RemoteUnidadServerFailureCreate(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteUnidadServerFailureStore extends RemoteUnidadState {
  const RemoteUnidadServerFailureStore(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteUnidadServerFailureList extends RemoteUnidadState {
  const RemoteUnidadServerFailureList(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteUnidadServerFailurePredictive extends RemoteUnidadState {
  const RemoteUnidadServerFailurePredictive(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
