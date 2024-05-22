part of 'remote_inspeccion_bloc.dart';

class RemoteInspeccionState extends Equatable {
  const RemoteInspeccionState();

  @override
  List<Object?> get props => [];
}

/// LOADING
class RemoteInspeccionLoading extends RemoteInspeccionState {}

/// INDEX
class RemoteInspeccionIndexLoading extends RemoteInspeccionState {}

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
