part of 'remote_inspeccion_bloc.dart';

class RemoteInspeccionState extends Equatable {
  const RemoteInspeccionState();

  @override
  List<Object?> get props => [];
}

class RemoteInspeccionLoading extends RemoteInspeccionState {}

class RemoteInspeccionCreateSuccess extends RemoteInspeccionState {
  const RemoteInspeccionCreateSuccess(this.objInspeccion);

  final InspeccionDataEntity? objInspeccion;

  @override
  List<Object?> get props => [ objInspeccion ];
}

class RemoteInspeccionResponseSuccess extends RemoteInspeccionState {
  const RemoteInspeccionResponseSuccess(this.apiResponse);

  final ApiResponseEntity apiResponse;

  @override
  List<Object?> get props => [ apiResponse ];
}

class RemoteInspeccionDataSourceSuccess extends RemoteInspeccionState {
  const RemoteInspeccionDataSourceSuccess(this.dataSource);

  final InspeccionDataSourceResEntity dataSource;

  @override
  List<Object?> get props => [ dataSource ];
}

class RemoteInspeccionFailure extends RemoteInspeccionState {
  const RemoteInspeccionFailure(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteInspeccionFailedMessage extends RemoteInspeccionState {
  const RemoteInspeccionFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}
