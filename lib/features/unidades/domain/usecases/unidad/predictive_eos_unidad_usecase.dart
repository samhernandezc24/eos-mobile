import 'package:eos_mobile/core/data/predictive.dart';
import 'package:eos_mobile/features/unidades/domain/entities/unidad/unidad_eos_predictive_list_entity.dart';
import 'package:eos_mobile/features/unidades/domain/repositories/unidad_eos_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class PredictiveEOSUnidadUseCase implements UseCase<DataState<List<UnidadEOSPredictiveListEntity>>, Predictive> {
  PredictiveEOSUnidadUseCase(this._unidadEOSRepository);

  final UnidadEOSRepository _unidadEOSRepository;

  @override
  Future<DataState<List<UnidadEOSPredictiveListEntity>>> call({required Predictive params}) {
    return _unidadEOSRepository.predictiveEOS(params);
  }
}
