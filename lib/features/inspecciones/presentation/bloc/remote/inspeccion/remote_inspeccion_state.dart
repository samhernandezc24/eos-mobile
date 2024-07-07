part of 'remote_inspeccion_bloc.dart';

@immutable
abstract class RemoteInspeccionState extends Equatable {
  const RemoteInspeccionState();

  @override
  List<Object?> get props => [];
}

/// INIT
class RemoteInspeccionInit extends RemoteInspeccionState {}

/// LOADING
class RemoteInspeccionLoading extends RemoteInspeccionState {}

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

/// SERVER FAILED MESSAGE
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

/// SERVER EXCEPTION
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
