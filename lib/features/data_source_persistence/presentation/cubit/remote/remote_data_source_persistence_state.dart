part of 'remote_data_source_persistence_cubit.dart';

class RemoteDataSourcePersistenceState extends Equatable {
  const RemoteDataSourcePersistenceState({required this.result});

  final bool result;

  @override
  List<Object?> get props => [ result ];
}
