part of 'remote_data_source_persistence_bloc.dart';

sealed class RemoteDataSourcePersistenceEvent extends Equatable {
  const RemoteDataSourcePersistenceEvent();

  @override
  List<Object?> get props => [];
}

/// [UpdateDataSourcePersistenceUseCase]
class UpdateDataSourcePersistence extends RemoteDataSourcePersistenceEvent {
  const UpdateDataSourcePersistence(this.varArgs);

  final DataSourcePersistence varArgs;

  @override
  List<Object?> get props => [ varArgs ];
}
