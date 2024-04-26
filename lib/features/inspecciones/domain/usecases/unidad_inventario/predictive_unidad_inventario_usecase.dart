import 'package:eos_mobile/core/data/predictive_search_req_data.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad_inventario/unidad_inventario_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_inventario_repository.dart';

class PredictiveUnidadInventarioUseCase implements UseCase<DataState<UnidadInventarioDataEntity>, PredictiveSearchReqEntity> {
  PredictiveUnidadInventarioUseCase(this._unidadInventarioRepository);

  final UnidadInventarioRepository _unidadInventarioRepository;

  @override
  Future<DataState<UnidadInventarioDataEntity>> call({required PredictiveSearchReqEntity params}) {
    return _unidadInventarioRepository.predictiveUnidadInventario(params);
  }
}
