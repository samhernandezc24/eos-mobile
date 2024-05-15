part of 'remote_categoria_item_bloc.dart';

sealed class RemoteCategoriaItemEvent extends Equatable {
  const RemoteCategoriaItemEvent();

  @override
  List<Object?> get props => [];
}

/// [ListCategoriaItemUseCase]
class ListCategoriasItems extends RemoteCategoriaItemEvent {
  const ListCategoriasItems(this.objData);

  final CategoriaEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

// /// [StoreCategoriaItemUseCase]
// class StoreCategoriaItem extends RemoteCategoriaItemEvent {
//   const StoreCategoriaItem(this.objData);

//   final CategoriaItemStoreReqEntity objData;

//   @override
//   List<Object?> get props => [ objData ];
// }

// /// [StoreDuplicateCategoriaItemUseCase]
// class StoreDuplicateCategoriaItem extends RemoteCategoriaItemEvent {
//   const StoreDuplicateCategoriaItem(this.objData);

//   final CategoriaItemDuplicateReqEntity objData;

//   @override
//   List<Object?> get props => [ objData ];
// }

// /// [UpdateCategoriaItemUseCase]
// class UpdateCategoriaItem extends RemoteCategoriaItemEvent {
//   const UpdateCategoriaItem(this.objData);

//   final CategoriaItemEntity objData;

//   @override
//   List<Object?> get props => [ objData ];
// }

// /// [DeleteCategoriaItemUseCase]
// class DeleteCategoriaItem extends RemoteCategoriaItemEvent {
//   const DeleteCategoriaItem(this.objData);

//   final CategoriaItemEntity objData;

//   @override
//   List<Object?> get props => [ objData ];
// }
