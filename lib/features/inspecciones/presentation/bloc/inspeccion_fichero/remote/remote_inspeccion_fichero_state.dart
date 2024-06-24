part of 'remote_inspeccion_fichero_bloc.dart';

class RemoteInspeccionFicheroState extends Equatable {
  const RemoteInspeccionFicheroState();

  @override
  List<Object?> get props => [];
}

/// INITIAL STATE
class RemoteInspeccionFicheroInitial extends RemoteInspeccionFicheroState {}

/// LIST
class RemoteInspeccionFicheroLoading extends RemoteInspeccionFicheroState {}

class RemoteInspeccionFicheroSuccess extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroSuccess(this.objResponse);

  final InspeccionFicheroEntity? objResponse;

  @override
  List<Object?> get props => [];
}

/// STORE
class RemoteInspeccionFicheroStoreLoading extends RemoteInspeccionFicheroState {}

class RemoteInspeccionFicheroStoreSuccess extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroStoreSuccess(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [];
}

/// DELETE
class RemoteInspeccionFicheroDeleteLoading extends RemoteInspeccionFicheroState {}

class RemoteInspeccionFicheroDeleteSuccess extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroDeleteSuccess(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [];
}

/// SERVER FAILED MESSAGE
class RemoteInspeccionFicheroServerFailedMessageList extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroServerFailedMessageList(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteInspeccionFicheroServerFailedMessageStore extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroServerFailedMessageStore(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteInspeccionFicheroServerFailedMessageDelete extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroServerFailedMessageDelete(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteInspeccionFicheroServerFailureList extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroServerFailureList(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteInspeccionFicheroServerFailureStore extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroServerFailureStore(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteInspeccionFicheroServerFailureDelete extends RemoteInspeccionFicheroState {
  const RemoteInspeccionFicheroServerFailureDelete(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
