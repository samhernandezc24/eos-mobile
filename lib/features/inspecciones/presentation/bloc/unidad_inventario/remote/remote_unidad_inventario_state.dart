part of 'remote_unidad_inventario_bloc.dart';

class RemoteUnidadInventarioState extends Equatable {
  const RemoteUnidadInventarioState();

  @override
  List<Object?> get props => [];
}

class RemoteUnidadInventarioLoading extends RemoteUnidadInventarioState {}

class RemoteUnidadInventarioSuccess extends RemoteUnidadInventarioState {
  const RemoteUnidadInventarioSuccess(this.unidades);

  final UnidadInventarioDataEntity? unidades;

  @override
  List<Object?> get props => [ unidades ];
}

class RemoteUnidadInventarioResponseSuccess extends RemoteUnidadInventarioState {
  const RemoteUnidadInventarioResponseSuccess(this.apiResponse);

  final ApiResponseEntity apiResponse;

  @override
  List<Object?> get props => [ apiResponse ];
}

class RemoteUnidadInventarioFailure extends RemoteUnidadInventarioState {
  const RemoteUnidadInventarioFailure(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteUnidadInventarioFailedMessage extends RemoteUnidadInventarioState {
  const RemoteUnidadInventarioFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}