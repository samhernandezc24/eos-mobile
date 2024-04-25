import 'package:eos_mobile/core/common/data/catalogos/predictive_search_req.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_predictive_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

class PredictiveUnidadUseCase implements UseCase<DataState<UnidadPredictiveDataEntity>, PredictiveSearchReqEntity> {
  PredictiveUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<UnidadPredictiveDataEntity>> call({required PredictiveSearchReqEntity params}) {
    return _unidadRepository.predictiveUnidad(params);
  }
}
