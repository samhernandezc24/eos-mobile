part of 'remote_data_source_persistence_bloc.dart';

class RemoteDataSourcePersistenceState extends Equatable {
  const RemoteDataSourcePersistenceState();

  @override
  List<Object?> get props => [];
}

/// INITIAL STATE
class RemoteDataSourcePersistenceInitial extends RemoteDataSourcePersistenceState {}

/// UPDATE
class RemoteDataSourcePersistenceUpdating extends RemoteDataSourcePersistenceState {}

class RemoteDataSourcePersistenceUpdateSuccess extends RemoteDataSourcePersistenceState {
  const RemoteDataSourcePersistenceUpdateSuccess(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteDataSourcePersistenceServerFailedMessage extends RemoteDataSourcePersistenceState {
  const RemoteDataSourcePersistenceServerFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteDataSourcePersistenceServerFailure extends RemoteDataSourcePersistenceState {
  const RemoteDataSourcePersistenceServerFailure(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
