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
  const RemoteInspeccionTipoSuccess(this.inspeccionesTipos);

  final List<InspeccionTipoEntity>? inspeccionesTipos;

  @override
  List<Object?> get props => [ inspeccionesTipos ];
}

/// STORE / UPDATE / DELETE
class RemoteInspeccionTipoServerResponseSuccess extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoServerResponseSuccess(this.objResponse);

  final ServerResponse objResponse;

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
