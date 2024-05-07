part of 'remote_inspeccion_bloc.dart';

class RemoteInspeccionState extends Equatable {
  const RemoteInspeccionState();

  @override
  List<Object?> get props => [];
}

/// LOADING
class RemoteInspeccionLoading extends RemoteInspeccionState {}

/// INITIALIZATION
class RemoteInspeccionInitialization extends RemoteInspeccionState {
  const RemoteInspeccionInitialization(this.objResponse);

  final InspeccionIndexEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DATASOURCE
class RemoteInspeccionDataSourceLoaded extends RemoteInspeccionState {
  const RemoteInspeccionDataSourceLoaded(this.objResponse);

  final InspeccionDataSourceResEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// CREATE
class RemoteInspeccionCreating extends RemoteInspeccionState {}

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
class RemoteInspeccionServerFailedMessage extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteInspeccionServerFailure extends RemoteInspeccionState {
  const RemoteInspeccionServerFailure(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
