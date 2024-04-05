part of 'remote_inspeccion_tipo_bloc.dart';

class RemoteInspeccionTipoState extends Equatable {
  const RemoteInspeccionTipoState();

  @override
  List<Object?> get props => [];
}

class RemoteInspeccionTipoLoading extends RemoteInspeccionTipoState {}

class RemoteInspeccionTipoSuccess extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoSuccess(this.inspeccionesTipos);

  final List<InspeccionTipoEntity>? inspeccionesTipos;

  @override
  List<Object?> get props => [ inspeccionesTipos ];
}

class RemoteInspeccionTipoResponseSuccess extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoResponseSuccess(this.apiResponse);

  final ApiResponseEntity apiResponse;

  @override
  List<Object?> get props => [ apiResponse ];
}

class RemoteInspeccionTipoFailure extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoFailure(this.failure);

  final DioException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteInspeccionTipoFailedMessage extends RemoteInspeccionTipoState {
  const RemoteInspeccionTipoFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}
