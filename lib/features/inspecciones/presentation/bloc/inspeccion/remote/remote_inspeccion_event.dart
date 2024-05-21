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
