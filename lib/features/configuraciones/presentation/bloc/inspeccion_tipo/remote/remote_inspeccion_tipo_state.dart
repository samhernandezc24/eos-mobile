part of 'remote_inspeccion_tipo_bloc.dart';

class RemoteInspeccionTipoState extends Equatable {
  const RemoteInspeccionTipoState();

  @override
  List<Object?> get props => [];
}

class RemoteInspeccionTipoInitial extends RemoteInspeccionTipoState { }

class RemoteInspeccionTipoLoading extends RemoteInspeccionTipoState { }

class RemoteInspeccionTipoDone extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoDone(this.inspeccionesTipos);

  final List<InspeccionTipoEntity> inspeccionesTipos;

  @override
  List<Object?> get props => [ inspeccionesTipos ];
}

class RemoteInspeccionTipoFailure extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoFailure(this.failure);

  final DioException? failure;

  @override
  List<Object?> get props => [ failure ];
}
