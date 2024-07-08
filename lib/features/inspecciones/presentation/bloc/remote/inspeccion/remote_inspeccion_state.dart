part of 'remote_inspeccion_bloc.dart';

@immutable
abstract class RemoteInspeccionState extends Equatable {
  const RemoteInspeccionState();

  @override
  List<Object?> get props => [];
}

/// INIT
class RemoteInspeccionInit extends RemoteInspeccionState {}

/// INDEX
class RemoteInspeccionIndexLoading extends RemoteInspeccionState {}

class RemoteInspeccionIndex extends RemoteInspeccionState {
  const RemoteInspeccionIndex(this.objResponse);

  final InspeccionIndexEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DATASOURCE
class RemoteInspeccionDataSourceLoading extends RemoteInspeccionState {}

class RemoteInspeccionDataSource extends RemoteInspeccionState {
  const RemoteInspeccionDataSource(this.objResponse);

  final InspeccionDataSourceEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// CREATE
class RemoteInspeccionCreateLoading extends RemoteInspeccionState {}

class RemoteInspeccionCreate extends RemoteInspeccionState {
  const RemoteInspeccionCreate(this.objResponse);

  final InspeccionCreateEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE
class RemoteInspeccionStoreLoading extends RemoteInspeccionState {}

class RemoteInspeccionStore extends RemoteInspeccionState {
  const RemoteInspeccionStore(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// FINISH
class RemoteInspeccionFinishLoading extends RemoteInspeccionState {}

class RemoteInspeccionFinish extends RemoteInspeccionState {
  const RemoteInspeccionFinish(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// CANCEL
class RemoteInspeccionCancelLoading extends RemoteInspeccionState {}

class RemoteInspeccionCancel extends RemoteInspeccionState {
  const RemoteInspeccionCancel(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteInspeccionServerFailedMessageIndex extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessageIndex(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionServerFailedMessageDataSource extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessageDataSource(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionServerFailedMessageCreate extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessageCreate(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionServerFailedMessageStore extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessageStore(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionServerFailedMessageFinish extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessageFinish(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionServerFailedMessageCancel extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessageCancel(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

/// SERVER EXCEPTION
class RemoteInspeccionServerExceptionMessageIndex extends RemoteInspeccionState {
  const RemoteInspeccionServerExceptionMessageIndex(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionServerExceptionMessageDataSource extends RemoteInspeccionState {
  const RemoteInspeccionServerExceptionMessageDataSource(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionServerExceptionMessageCreate extends RemoteInspeccionState {
  const RemoteInspeccionServerExceptionMessageCreate(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionServerExceptionMessageStore extends RemoteInspeccionState {
  const RemoteInspeccionServerExceptionMessageStore(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionServerExceptionMessageFinish extends RemoteInspeccionState {
  const RemoteInspeccionServerExceptionMessageFinish(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionServerExceptionMessageCancel extends RemoteInspeccionState {
  const RemoteInspeccionServerExceptionMessageCancel(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}
