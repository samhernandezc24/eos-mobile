part of 'remote_categoria_item_bloc.dart';

sealed class RemoteCategoriaItemEvent extends Equatable {
  const RemoteCategoriaItemEvent();

  @override
  List<Object?> get props => [];
}

class ListCategoriasItems extends RemoteCategoriaItemEvent {
  const ListCategoriasItems(this.categoria);

  final CategoriaEntity categoria;

  @override
  List<Object?> get props => [ categoria ];
}

class StoreCategoriaItem extends RemoteCategoriaItemEvent {
  const StoreCategoriaItem(this.categoriaItem);

  final CategoriaItemReqEntity categoriaItem;

  @override
  List<Object?> get props => [ categoriaItem ];
}

class StoreDuplicateCategoriaItem extends RemoteCategoriaItemEvent {
  const StoreDuplicateCategoriaItem(this.categoriaItem);

  final CategoriaItemDuplicateReqEntity categoriaItem;

  @override
  List<Object?> get props => [ categoriaItem ];
}

class UpdateCategoriaItem extends RemoteCategoriaItemEvent {
  const UpdateCategoriaItem(this.categoriaItem);

  final CategoriaItemEntity categoriaItem;

  @override
  List<Object?> get props => [ categoriaItem ];
}

class DeleteCategoriaItem extends RemoteCategoriaItemEvent {
  const DeleteCategoriaItem(this.categoriaItem);

  final CategoriaItemEntity categoriaItem;

  @override
  List<Object?> get props => [ categoriaItem ];
}
