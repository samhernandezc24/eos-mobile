part of 'remote_inspeccion_bloc.dart';

class RemoteInspeccionState extends Equatable {
  const RemoteInspeccionState();

  @override
  List<Object?> get props => [];
}

/// LOADING
class RemoteInspeccionLoading extends RemoteInspeccionState {}

/// INDEX
class RemoteInspeccionIndexLoading extends RemoteInspeccionState {}

class RemoteInspeccionIndexLoaded extends RemoteInspeccionState {
  const RemoteInspeccionIndexLoaded(this.objResponse);

  final InspeccionIndexEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DATA SOURCE
class RemoteInspeccionDataSourceLoaded extends RemoteInspeccionState {
  const RemoteInspeccionDataSourceLoaded(this.objResponse);

  final InspeccionDataSourceResEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// CREATE
class RemoteInspeccionCreateLoading extends RemoteInspeccionState {}

class RemoteInspeccionCreateLoaded extends RemoteInspeccionState {
  const RemoteInspeccionCreateLoaded(this.objResponse);

  final InspeccionCreateEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE
class RemoteInspeccionStoring extends RemoteInspeccionState {}

class RemoteInspeccionStored extends RemoteInspeccionState {
  const RemoteInspeccionStored(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteInspeccionServerFailedMessageIndex extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessageIndex(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteInspeccionServerFailedMessageDataSource extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessageDataSource(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteInspeccionServerFailedMessageCreate extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessageCreate(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteInspeccionServerFailedMessageStore extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessageStore(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteInspeccionServerFailureIndex extends RemoteInspeccionState {
  const RemoteInspeccionServerFailureIndex(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteInspeccionServerFailureDataSource extends RemoteInspeccionState {
  const RemoteInspeccionServerFailureDataSource(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteInspeccionServerFailureCreate extends RemoteInspeccionState {
  const RemoteInspeccionServerFailureCreate(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteInspeccionServerFailureStore extends RemoteInspeccionState {
  const RemoteInspeccionServerFailureStore(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
