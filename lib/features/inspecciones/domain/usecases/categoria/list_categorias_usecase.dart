import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';

class ListCategoriasUseCase implements UseCase<DataState<List<CategoriaEntity>>, InspeccionTipoEntity> {
  ListCategoriasUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<List<CategoriaEntity>>> call({required InspeccionTipoEntity params}) {
    return _categoriaRepository.listCategorias(params);
  }
}
