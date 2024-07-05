part of 'remote_inspeccion_tipo_bloc.dart';

@immutable
abstract class RemoteInspeccionTipoState extends Equatable {
  const RemoteInspeccionTipoState();

  @override
  List<Object?> get props => [];
}

/// INIT
class RemoteInspeccionTipoInit extends RemoteInspeccionTipoState {}

/// LIST
class RemoteInspeccionTipoLoading extends RemoteInspeccionTipoState {}

class RemoteInspeccionTipoList extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoList(this.objResponse);

  final List<InspeccionTipoEntity>? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE
class RemoteInspeccionTipoStoreLoading extends RemoteInspeccionTipoState {}

class RemoteInspeccionTipoStore extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoStore(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// UPDATE
class RemoteInspeccionTipoUpdateLoading extends RemoteInspeccionTipoState {}

class RemoteInspeccionTipoUpdate extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoUpdate(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DELETE
class RemoteInspeccionTipoDeleteLoading extends RemoteInspeccionTipoState {}

class RemoteInspeccionTipoDelete extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoDelete(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteInspeccionTipoServerFailedMessageList extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoServerFailedMessageList(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionTipoServerFailedMessageStore extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoServerFailedMessageStore(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionTipoServerFailedMessageUpdate extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoServerFailedMessageUpdate(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionTipoServerFailedMessageDelete extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoServerFailedMessageDelete(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

/// SERVER EXCEPTION
class RemoteInspeccionTipoServerExceptionMessageList extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoServerExceptionMessageList(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionTipoServerExceptionMessageStore extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoServerExceptionMessageStore(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionTipoServerExceptionMessageUpdate extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoServerExceptionMessageUpdate(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteInspeccionTipoServerExceptionMessageDelete extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoServerExceptionMessageDelete(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}
