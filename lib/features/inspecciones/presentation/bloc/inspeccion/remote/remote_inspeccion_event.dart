part of 'remote_inspeccion_bloc.dart';

sealed class RemoteInspeccionEvent extends Equatable {
  const RemoteInspeccionEvent();

  @override
  List<Object?> get props => [];
}

/// [IndexInspeccionUseCase]
class FetchInspeccionIndex extends RemoteInspeccionEvent {}

/// [DataSourceInspeccionUseCase]
class FetchInspeccionDataSource extends RemoteInspeccionEvent {
  const FetchInspeccionDataSource(this.varArgs);

  final DataSource varArgs;

  @override
  List<Object?> get props => [ varArgs ];
}

/// [CreateInspeccionUseCase]
class FetchInspeccionCreate extends RemoteInspeccionEvent {}

/// [StoreInspeccionUseCase]
class StoreInspeccion extends RemoteInspeccionEvent {
  const StoreInspeccion(this.objData);

  final InspeccionStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [CancelInspeccionUseCase]
class CancelInspeccion extends RemoteInspeccionEvent {
  const CancelInspeccion(this.objData);

  final InspeccionIdReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
