part of 'remote_categoria_bloc.dart';

class RemoteCategoriaState extends Equatable {
  const RemoteCategoriaState();

  @override
  List<Object?> get props => [];
}

class RemoteCategoriaLoading extends RemoteCategoriaState { }

class RemoteCategoriaDone extends RemoteCategoriaState {
  const RemoteCategoriaDone(this.categorias);

  final List<CategoriaEntity>? categorias;

  @override
  List<Object?> get props => [ categorias ];
}

class RemoteCategoriaCreateDone extends RemoteCategoriaState {
  const RemoteCategoriaCreateDone(this.apiResponse);

  final ApiResponse apiResponse;

  @override
  List<Object?> get props => [ apiResponse ];
}

class RemiteCategoriaFailedMessage extends RemoteCategoriaState {
  const RemiteCategoriaFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteCategoriaFailure extends RemoteCategoriaState {
  const RemoteCategoriaFailure(this.failure);

  final DioException? failure;

  @override
  List<Object?> get props => [ failure ];
}
