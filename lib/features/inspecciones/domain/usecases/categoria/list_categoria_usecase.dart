import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class ListCategoriaUseCase implements UseCase<DataState<List<CategoriaEntity>>, InspeccionTipoEntity> {
  ListCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<List<CategoriaEntity>>> call({required InspeccionTipoEntity params}) {
    return _categoriaRepository.list(params);
  }
}
