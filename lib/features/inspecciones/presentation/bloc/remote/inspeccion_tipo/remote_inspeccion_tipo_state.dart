part of 'remote_inspeccion_tipo_bloc.dart';

@immutable
abstract class RemoteInspeccionTipoState extends Equatable {
  const RemoteInspeccionTipoState();

  @override
  List<Object?> get props => [];
}

/// INIT
class RemoteInspeccionTipoInit extends RemoteInspeccionTipoState {}

/// LOADING
class RemoteInspeccionTipoLoading extends RemoteInspeccionTipoState {}

/// LIST
class RemoteInspeccionTipoList extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoList(this.objResponse);

  final List<InspeccionTipoEntity>? objResponse;

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

/// SERVER EXCEPTION
class RemoteInspeccionTipoServerExceptionMessageList extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoServerExceptionMessageList(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}
