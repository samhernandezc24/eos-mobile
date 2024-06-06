part of 'remote_inspeccion_bloc.dart';

class RemoteInspeccionState extends Equatable {
  const RemoteInspeccionState();

  @override
  List<Object?> get props => [];
}

/// INITIAL STATE
class RemoteInspeccionInitial extends RemoteInspeccionState {}

/// LOADING
class RemoteInspeccionLoading extends RemoteInspeccionState {}

/// INSPECCION LOADED (INDEX, DATASOURCE)
class RemoteInspeccionListLoaded extends RemoteInspeccionState {
  const RemoteInspeccionListLoaded(this.objResponseIndex, this.objResponseDataSource);

  final InspeccionIndexEntity? objResponseIndex;
  final InspeccionDataSourceResEntity? objResponseDataSource;

  @override
  List<Object?> get props => [ objResponseIndex, objResponseDataSource ];
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

/// STORE
class RemoteInspeccionCanceling extends RemoteInspeccionState {}

class RemoteInspeccionCanceled extends RemoteInspeccionState {
  const RemoteInspeccionCanceled(this.objResponse);

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
