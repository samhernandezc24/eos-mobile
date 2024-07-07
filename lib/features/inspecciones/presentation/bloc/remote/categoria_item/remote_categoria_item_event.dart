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

/// [RemoteStoreDuplicateCategoriaItemUseCase]
class StoreDuplicateCategoriaItem extends RemoteCategoriaItemEvent {
  const StoreDuplicateCategoriaItem(this.objData);

  final CategoriaItemStoreDuplicateReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemoteUpdateCategoriaItemUseCase]
class UpdateCategoriaItem extends RemoteCategoriaItemEvent {
  const UpdateCategoriaItem(this.objData);

  final CategoriaItemUpdateReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemoteDeleteCategoriaItemUseCase]
class DeleteCategoriaItem extends RemoteCategoriaItemEvent {
  const DeleteCategoriaItem(this.objData);

  final CategoriaItemParamsEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
