part of 'remote_categoria_bloc.dart';

sealed class RemoteCategoriaEvent extends Equatable {
  const RemoteCategoriaEvent();

  @override
  List<Object?> get props => [];
}

/// [ListCategoriaUseCase]
class ListCategorias extends RemoteCategoriaEvent {
  const ListCategorias(this.objData);

  final InspeccionTipoEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [StoreCategoriaUseCase]
class StoreCategoria extends RemoteCategoriaEvent {
  const StoreCategoria(this.objData);

  final CategoriaStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [UpdateCategoriaUseCase]
class UpdateCategoria extends RemoteCategoriaEvent {
  const UpdateCategoria(this.objData);

  final CategoriaEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [DeleteCategoriaUseCase]
class DeleteCategoria extends RemoteCategoriaEvent {
  const DeleteCategoria(this.objData);

  final CategoriaEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
