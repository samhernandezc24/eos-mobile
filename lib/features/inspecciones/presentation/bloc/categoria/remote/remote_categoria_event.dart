part of 'remote_categoria_bloc.dart';

sealed class RemoteCategoriaEvent extends Equatable {
  const RemoteCategoriaEvent();

  @override
  List<Object?> get props => [];
}

class ListCategorias extends RemoteCategoriaEvent {
  const ListCategorias(this.inspeccionTipo);

  final InspeccionTipoEntity inspeccionTipo;

  @override
  List<Object?> get props => [ inspeccionTipo ];
}

class StoreCategoria extends RemoteCategoriaEvent {
  const StoreCategoria(this.categoria);

  final CategoriaStoreReqEntity categoria;

  @override
  List<Object?> get props => [ categoria ];
}

class UpdateCategoria extends RemoteCategoriaEvent {
  const UpdateCategoria(this.categoria);

  final CategoriaEntity categoria;

  @override
  List<Object?> get props => [ categoria ];
}

class DeleteCategoria extends RemoteCategoriaEvent {
  const DeleteCategoria(this.categoria);

  final CategoriaEntity categoria;

  @override
  List<Object?> get props => [ categoria ];
}

// part of 'remote_categoria_bloc.dart';

// sealed class RemoteCategoriaEvent extends Equatable {
//   const RemoteCategoriaEvent();

//   @override
//   List<Object?> get props => [];
// }

// /// [ListCategoriaUseCase]
// class ListCategorias extends RemoteCategoriaEvent {
//   const ListCategorias(this.objData);

//   final InspeccionTipoEntity objData;

//   @override
//   List<Object?> get props => [ objData ];
// }

// /// [StoreCategoriaUseCase]
// class StoreCategoria extends RemoteCategoriaEvent {
//   const StoreCategoria(this.objData);

//   final CategoriaStoreReqEntity objData;

//   @override
//   List<Object?> get props => [ objData ];
// }

// /// [UpdateCategoriaUseCase]
// class UpdateCategoria extends RemoteCategoriaEvent {
//   const UpdateCategoria(this.objData);

//   final CategoriaEntity objData;

//   @override
//   List<Object?> get props => [ objData ];
// }

// /// [DeleteCategoriaUseCase]
// class DeleteCategoria extends RemoteCategoriaEvent {
//   const DeleteCategoria(this.objData);

//   final CategoriaEntity objData;

//   @override
//   List<Object?> get props => [ objData ];
// }
