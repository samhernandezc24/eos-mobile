part of 'remote_inspeccion_tipo_bloc.dart';

sealed class RemoteInspeccionTipoEvent extends Equatable {
  const RemoteInspeccionTipoEvent();

  @override
  List<Object?> get props => [];
}

class FetcInspeccionesTipos extends RemoteInspeccionTipoEvent {
  const FetcInspeccionesTipos();
}
