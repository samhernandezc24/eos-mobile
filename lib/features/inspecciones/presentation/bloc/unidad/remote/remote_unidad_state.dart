part of 'remote_unidad_bloc.dart';

class RemoteUnidadState extends Equatable {
  const RemoteUnidadState();

  @override
  List<Object?> get props => [];
}

/// LOADING
class RemoteUnidadLoading extends RemoteUnidadState {}

/// INITIALIZATION
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
class RemoteUnidadStoring extends RemoteUnidadState {}

class RemoteUnidadStored extends RemoteUnidadState {
  const RemoteUnidadStored(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// LIST
class RemoteUnidadSearchLoading extends RemoteUnidadState {}

class RemoteUnidadSearchLoaded extends RemoteUnidadState {
  const RemoteUnidadSearchLoaded(this.unidades);

  final List<UnidadSearchEntity>? unidades;

  @override
  List<Object?> get props => [ unidades ];
}

/// EDIT
class RemoteUnidadEditing extends RemoteUnidadState {}

class RemoteUnidadEditLoaded extends RemoteUnidadState {
  const RemoteUnidadEditLoaded(this.objResponse);

  final UnidadEditEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// UPDATE
class RemoteUnidadUpdating extends RemoteUnidadState {}

class RemoteUnidadUpdated extends RemoteUnidadState {
  const RemoteUnidadUpdated(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DELETE
class RemoteUnidadDeleting extends RemoteUnidadState {}

class RemoteUnidadDeleted extends RemoteUnidadState {
  const RemoteUnidadDeleted(this.objResponse);

  final ServerResponse? objResponse;

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
