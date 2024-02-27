import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class RemoteCategoriasState extends Equatable {
  const RemoteCategoriasState({
    this.inspeccionesCategorias,
    this.failure,
  });

  final List<CategoriaEntity>? inspeccionesCategorias;
  final DioException? failure;

  @override
  List<Object?> get props => [inspeccionesCategorias, failure];
}

class RemoteCategoriasEmpty extends RemoteCategoriasState {
  const RemoteCategoriasEmpty();
}

class RemoteCategoriasLoading extends RemoteCategoriasState {
  const RemoteCategoriasLoading();
}

class RemoteCategoriasDone extends RemoteCategoriasState {
  const RemoteCategoriasDone(List<CategoriaEntity> inspeccionCategoria) : super(inspeccionesCategorias: inspeccionCategoria);
}

class RemoteCategoriasFailure extends RemoteCategoriasState {
  const RemoteCategoriasFailure(DioException failure) : super(failure: failure);
}
