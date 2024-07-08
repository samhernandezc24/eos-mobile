part of 'remote_inspeccion_fichero_bloc.dart';

@immutable
abstract class RemoteInspeccionFicheroState extends Equatable {
  const RemoteInspeccionFicheroState();

  @override
  List<Object?> get props => [];
}

/// INIT
class RemoteInspeccionFicheroInit extends RemoteInspeccionFicheroState {}

/// LIST
class RemoteInspeccionFicheroListLoading extends RemoteInspeccionFicheroState {}

class RemoteInspeccionFicheroList extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroList(this.objResponse);

  final InspeccionFicheroEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE
class RemoteInspeccionFicheroStoreLoading extends RemoteInspeccionFicheroState {}

class RemoteInspeccionFicheroStore extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroStore(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DELETE
class RemoteInspeccionFicheroDeleteLoading extends RemoteInspeccionFicheroState {}

class RemoteInspeccionFicheroDelete extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroDelete(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteInspeccionFicheroServerFailedMessageList extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroServerFailedMessageList(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionFicheroServerFailedMessageStore extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroServerFailedMessageStore(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionFicheroServerFailedMessageDelete extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroServerFailedMessageDelete(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

/// SERVER EXCEPTION
class RemoteInspeccionFicheroServerExceptionMessageList extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroServerExceptionMessageList(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionFicheroServerExceptionMessageStore extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroServerExceptionMessageStore(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionFicheroServerExceptionMessageDelete extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroServerExceptionMessageDelete(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}
