import 'package:eos_mobile/core/common/data/catalogos/predictive_search_req.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_inventario_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

class PredictiveUnidadInventarioUseCase implements UseCase<DataState<UnidadInventarioEntity>, PredictiveSearchReqEntity> {
  PredictiveUnidadInventarioUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<UnidadInventarioEntity>> call({required PredictiveSearchReqEntity params}) {
    return _unidadRepository.predictiveUnidadInventario(params);
  }
}
