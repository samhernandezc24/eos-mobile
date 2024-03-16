part of 'remote_categoria_bloc.dart';

sealed class RemoteCategoriaEvent extends Equatable {
  const RemoteCategoriaEvent();

  @override
  List<Object?> get props => [];
}

class FetchCategoriasByIdInspeccionTipo extends RemoteCategoriaEvent {
  const FetchCategoriasByIdInspeccionTipo(this.inspeccionTipoReq);

  final InspeccionTipoReqEntity inspeccionTipoReq;

  @override
  List<Object?> get props => [ inspeccionTipoReq ];
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
  const DeleteCategoria(this.categoriaReq);

  final CategoriaReqEntity categoriaReq;

  @override
  List<Object?> get props => [ categoriaReq ];
}
