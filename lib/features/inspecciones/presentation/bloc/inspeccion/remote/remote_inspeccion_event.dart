part of 'remote_inspeccion_bloc.dart';

sealed class RemoteInspeccionEvent extends Equatable {
  const RemoteInspeccionEvent();

  @override
  List<Object?> get props => [];
}

/// [IndexInspeccionUseCase], [DataSourceInspeccionUseCase]
class InitializeInspeccion extends RemoteInspeccionEvent {
  const InitializeInspeccion(this.objData);

  final DataSource objData;

  @override
  List<Object?> get props => [ objData ];
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
