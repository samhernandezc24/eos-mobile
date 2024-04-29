part of 'remote_inspeccion_bloc.dart';

sealed class RemoteInspeccionEvent extends Equatable {
  const RemoteInspeccionEvent();

  @override
  List<Object?> get props => [];
}

class CreateInspeccionData extends RemoteInspeccionEvent {}

class StoreInspeccion extends RemoteInspeccionEvent {
  const StoreInspeccion(this.inspeccion);

  final InspeccionReqEntity inspeccion;

  @override
  List<Object?> get props => [ inspeccion ];
}

class DataSourceInspeccion extends RemoteInspeccionEvent {
  const DataSourceInspeccion(this.objData);

  final Map<String, dynamic> objData;

  @override
  List<Object?> get props => [ objData ];
}
