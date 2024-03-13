import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/categoria_repository.dart';

class GetCategoriasByIdUseCase {
  GetCategoriasByIdUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  Future<DataState<List<CategoriaEntity>>> call(InspeccionReqEntity inspeccionId) async {
    return await _categoriaRepository.getCategoriasByIdInspeccion(inspeccionId);
  }
}
