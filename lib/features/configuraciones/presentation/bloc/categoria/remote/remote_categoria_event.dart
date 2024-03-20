part of 'remote_categoria_bloc.dart';

sealed class RemoteCategoriaEvent extends Equatable {
  const RemoteCategoriaEvent();

  @override
  List<Object?> get props => [];
}

class FetchCategoriasByIdInspeccionTipo extends RemoteCategoriaEvent {
  const FetchCategoriasByIdInspeccionTipo(this.inspeccionTipo);

  final InspeccionTipoEntity inspeccionTipo;

  @override
  List<Object?> get props => [ inspeccionTipo ];
}

class CreateCategoria extends RemoteCategoriaEvent {
  const CreateCategoria(this.categoriaReq);

  final CategoriaReqEntity categoriaReq;

  @override
  List<Object?> get props => [ categoriaReq ];
}

class UpdateCategoria extends RemoteCategoriaEvent {
  const UpdateCategoria(this.categoriaReq);

  final CategoriaReqEntity categoriaReq;

  @override
  List<Object?> get props => [ categoriaReq ];
}

class DeleteCategoria extends RemoteCategoriaEvent {
  const DeleteCategoria(this.categoria);

  final CategoriaEntity categoria;

  @override
  List<Object?> get props => [ categoria ];
}
