import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteListCategoriaUseCase implements UseCase<DataState<List<CategoriaEntity>>, InspeccionTipoIdParamEntity> {
  RemoteListCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<List<CategoriaEntity>>> call({required InspeccionTipoIdParamEntity params}) async {
    return _categoriaRepository.list(params);
  }
}
