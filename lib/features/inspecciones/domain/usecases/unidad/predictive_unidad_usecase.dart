import 'package:eos_mobile/core/data/predictive.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_predictive_list_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class PredictiveUnidadUseCase implements UseCase<DataState<List<UnidadPredictiveListEntity>>, Predictive> {
  PredictiveUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<List<UnidadPredictiveListEntity>>> call({required Predictive params}) {
    return _unidadRepository.predictive(params);
  }
}
