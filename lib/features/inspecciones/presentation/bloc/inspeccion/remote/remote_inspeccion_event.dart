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
  const FetchInspeccionDataSource(this.objData);

  final Map<String, dynamic> objData;

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
