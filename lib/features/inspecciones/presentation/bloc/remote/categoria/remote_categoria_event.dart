part of 'remote_categoria_bloc.dart';

@immutable
abstract class RemoteCategoriaEvent extends Equatable {
  const RemoteCategoriaEvent();

  @override
  List<Object?> get props => [];
}

/// [RemoteListCategoriaUseCase]
class ListCategorias extends RemoteCategoriaEvent {
  const ListCategorias(this.objData);

  final InspeccionTipoIdParamEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemoteStoreCategoriaUseCase]
class StoreCategoria extends RemoteCategoriaEvent {
  const StoreCategoria(this.objData);

  final CategoriaStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemoteUpdateCategoriaUseCase]
class UpdateCategoria extends RemoteCategoriaEvent {
  const UpdateCategoria(this.objData);

  final CategoriaUpdateReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [RemoteDeleteCategoriaUseCase]
class DeleteCategoria extends RemoteCategoriaEvent {
  const DeleteCategoria(this.objData);

  final CategoriaParamsEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
