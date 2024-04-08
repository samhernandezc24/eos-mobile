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

  final CategoriaReqEntity categoria;

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
