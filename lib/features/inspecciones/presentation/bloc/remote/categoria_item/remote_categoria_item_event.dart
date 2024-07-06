part of 'remote_categoria_item_bloc.dart';

@immutable
abstract class RemoteCategoriaItemEvent extends Equatable {
  const RemoteCategoriaItemEvent();

  @override
  List<Object?> get props => [];
}

/// [RemoteListCategoriaItemUseCase]
class ListCategoriasItems extends RemoteCategoriaItemEvent {
  const ListCategoriasItems(this.objData);

  final CategoriaIdParamEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemoteStoreCategoriaItemUseCase]
class StoreCategoriaItem extends RemoteCategoriaItemEvent {
  const StoreCategoriaItem(this.objData);

  final CategoriaItemStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
