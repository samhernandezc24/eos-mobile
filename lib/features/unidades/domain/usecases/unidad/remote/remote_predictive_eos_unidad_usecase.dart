import 'package:eos_mobile/features/unidades/domain/entities/unidad/unidad_eos_predictive_entity.dart';
import 'package:eos_mobile/features/unidades/domain/repositories/unidad_eos_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemotePredictiveEOSUnidadUseCase implements UseCase<DataState<List<UnidadEOSPredictiveEntity>>, Predictive> {
  RemotePredictiveEOSUnidadUseCase(this._unidadEOSRepository);

  final UnidadEOSRepository _unidadEOSRepository;

  @override
  Future<DataState<List<UnidadEOSPredictiveEntity>>> call({required Predictive params}) async {
    return _unidadEOSRepository.predictiveEOS(params);
  }
}
