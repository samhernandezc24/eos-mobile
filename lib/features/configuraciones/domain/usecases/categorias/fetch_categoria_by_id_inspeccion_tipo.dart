import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/categoria_repository.dart';

class FetchCategoriasByIdInspeccionTipoUseCase implements UseCase<DataState<List<CategoriaEntity>>, InspeccionTipoEntity> {
  FetchCategoriasByIdInspeccionTipoUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<List<CategoriaEntity>>> call(InspeccionTipoEntity params) async {
    return _categoriaRepository.fetchCategoriasByIdInspeccionTipo(params);
  }
}
