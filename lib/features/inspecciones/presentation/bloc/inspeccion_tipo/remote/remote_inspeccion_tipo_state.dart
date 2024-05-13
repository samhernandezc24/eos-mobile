part of 'remote_inspeccion_tipo_bloc.dart';

class RemoteInspeccionTipoState extends Equatable {
  const RemoteInspeccionTipoState();

  @override
  List<Object?> get props => [];
}

/// LOADING
class RemoteInspeccionTipoLoading extends RemoteInspeccionTipoState {}

/// LIST
class RemoteInspeccionTipoSuccess extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoSuccess(this.objResponse);

  final List<InspeccionTipoEntity>? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE
class RemoteInspeccionTipoStoring extends RemoteInspeccionTipoState {}

class RemoteInspeccionTipoStored extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoStored(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// UPDATE
class RemoteInspeccionTipoUpdating extends RemoteInspeccionTipoState {}

class RemoteInspeccionTipoUpdated extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoUpdated(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DELETE
class RemoteInspeccionTipoDeleting extends RemoteInspeccionTipoState {}

class RemoteInspeccionTipoDeleted extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoDeleted(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteInspeccionTipoServerFailedMessage extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoServerFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteInspeccionTipoServerFailure extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoServerFailure(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
