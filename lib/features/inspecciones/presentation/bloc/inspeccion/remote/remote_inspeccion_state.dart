part of 'remote_inspeccion_bloc.dart';

class RemoteInspeccionState extends Equatable {
  const RemoteInspeccionState();

  @override
  List<Object?> get props => [];
}

/// INITIAL STATE
class RemoteInspeccionInitial extends RemoteInspeccionState {}

/// INDEX
class RemoteInspeccionIndexLoading extends RemoteInspeccionState {}

class RemoteInspeccionIndexSuccess extends RemoteInspeccionState {
  const RemoteInspeccionIndexSuccess(this.objResponse);

  final InspeccionIndexEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DATASOURCE
class RemoteInspeccionDataSourceLoading extends RemoteInspeccionState {}

class RemoteInspeccionDataSourceSuccess extends RemoteInspeccionState {
  const RemoteInspeccionDataSourceSuccess(this.objResponse);

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
class RemoteInspeccionStoreLoading extends RemoteInspeccionState {}

class RemoteInspeccionStoreSuccess extends RemoteInspeccionState {
  const RemoteInspeccionStoreSuccess(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// CANCEL
class RemoteInspeccionCanceling extends RemoteInspeccionState {}

class RemoteInspeccionCanceledSuccess extends RemoteInspeccionState {
  const RemoteInspeccionCanceledSuccess(this.objResponse);

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

class RemoteInspeccionServerFailedMessageCancel extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessageCancel(this.errorMessage);

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

class RemoteInspeccionServerFailureCancel extends RemoteInspeccionState {
  const RemoteInspeccionServerFailureCancel(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
