part of 'remote_inspeccion_bloc.dart';

class RemoteInspeccionState extends Equatable {
  const RemoteInspeccionState();

  @override
  List<Object?> get props => [];
}

/// LOADING
class RemoteInspeccionLoading extends RemoteInspeccionState {}

/// INDEX
class RemoteInspeccionIndexLoaded extends RemoteInspeccionState {
  const RemoteInspeccionIndexLoaded(this.objResponse);

  final InspeccionIndexEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DATA SOURCE
class RemoteInspeccionDataSourceLoaded extends RemoteInspeccionState {
  const RemoteInspeccionDataSourceLoaded(this.objResponse);

  final InspeccionDataSourceResEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteInspeccionServerFailedMessage extends RemoteInspeccionState {
  const RemoteInspeccionServerFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteInspeccionServerFailure extends RemoteInspeccionState {
  const RemoteInspeccionServerFailure(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
