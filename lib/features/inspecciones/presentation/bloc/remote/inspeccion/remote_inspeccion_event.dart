part of 'remote_inspeccion_bloc.dart';

@immutable
abstract class RemoteInspeccionEvent extends Equatable {
  const RemoteInspeccionEvent();

  @override
  List<Object?> get props => [];
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
