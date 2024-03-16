import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/categoria_repository.dart';

class FetchCategoriaByIdInspeccionTipoUseCase implements UseCase<DataState<List<CategoriaEntity>>, InspeccionTipoReqEntity> {
  FetchCategoriaByIdInspeccionTipoUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<List<CategoriaEntity>>> call(InspeccionTipoReqEntity inspeccionTipoReq) async {
    return _categoriaRepository.fetchCategoriasByIdInspeccionTipo(inspeccionTipoReq);
  }
}
