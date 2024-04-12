part of 'remote_categoria_item_bloc.dart';

class RemoteCategoriaItemState extends Equatable {
  const RemoteCategoriaItemState();

  @override
  List<Object?> get props => [];
}

class RemoteCategoriaItemLoading extends RemoteCategoriaItemState {}

class RemoteCategoriaItemSuccess extends RemoteCategoriaItemState {
  const RemoteCategoriaItemSuccess(this.categoriasItems);

  final List<CategoriaItemEntity>? categoriasItems;

  @override
  List<Object?> get props => [ categoriasItems ];
}

class RemoteCategoriaItemResponseSuccess extends RemoteCategoriaItemState {
  const RemoteCategoriaItemResponseSuccess(this.apiResponse);

  final ApiResponseEntity apiResponse;

  @override
  List<Object?> get props => [ apiResponse ];
}

class RemoteCategoriaItemFailure extends RemoteCategoriaItemState {
  const RemoteCategoriaItemFailure(this.failure);

  final DioException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteCategoriaItemFailedMessage extends RemoteCategoriaItemState {
  const RemoteCategoriaItemFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}