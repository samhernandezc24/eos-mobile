part of 'remote_inspeccion_tipo_bloc.dart';

@immutable
abstract class RemoteInspeccionTipoEvent extends Equatable {
  const RemoteInspeccionTipoEvent();

  @override
  List<Object?> get props => [];
}

/// [RemoteListInspeccionTipoUseCase]
class ListInspeccionesTipos extends RemoteInspeccionTipoEvent {}
