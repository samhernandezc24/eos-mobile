part of 'remote_unidad_bloc.dart';

class RemoteUnidadState extends Equatable {
  const RemoteUnidadState();

  @override
  List<Object?> get props => [];
}

class RemoteUnidadLoading extends RemoteUnidadState {}

class RemoteUnidadSuccess extends RemoteUnidadState {
  const RemoteUnidadSuccess(this.categorias);

  final List<CategoriaEntity>? categorias;

  @override
  List<Object?> get props => [ categorias ];
}

class RemoteUnidadCreateSuccess extends RemoteUnidadState {
  const RemoteUnidadCreateSuccess(this.unidadData);

  final UnidadDataEntity? unidadData;

  @override
  List<Object?> get props => [ unidadData ];
}

class RemoteUnidadResponseSuccess extends RemoteUnidadState {
  const RemoteUnidadResponseSuccess(this.apiResponse);

  final ApiResponseEntity apiResponse;

  @override
  List<Object?> get props => [ apiResponse ];
}

class RemoteUnidadFailure extends RemoteUnidadState {
  const RemoteUnidadFailure(this.failure);

  final DioException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteUnidadFailedMessage extends RemoteUnidadState {
  const RemoteUnidadFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}
