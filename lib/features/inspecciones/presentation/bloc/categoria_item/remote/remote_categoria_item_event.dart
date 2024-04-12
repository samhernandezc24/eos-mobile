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
