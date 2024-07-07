part of 'remote_inspeccion_bloc.dart';

@immutable
abstract class RemoteInspeccionEvent extends Equatable {
  const RemoteInspeccionEvent();

  @override
  List<Object?> get props => [];
}

/// [RemoteIndexInspeccionUseCase]
class IndexInspeccion extends RemoteInspeccionEvent {}

/// [RemoteDataSourceInspeccionUseCase]
class DataSourceInspeccion extends RemoteInspeccionEvent {
  const DataSourceInspeccion(this.varArgs);

  final DataSource varArgs;

  @override
  List<Object?> get props => [ varArgs ];
}

/// [RemoteCreateInspeccionUseCase]
class CreateInspeccion extends RemoteInspeccionEvent {}

/// [RemoteStoreInspeccionUseCase]
class StoreInspeccion extends RemoteInspeccionEvent {
  const StoreInspeccion(this.objData);

  final InspeccionStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemoteCancelInspeccionUseCase]
class CancelInspeccion extends RemoteInspeccionEvent {
  const CancelInspeccion(this.objData);

  final InspeccionIdParamEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
