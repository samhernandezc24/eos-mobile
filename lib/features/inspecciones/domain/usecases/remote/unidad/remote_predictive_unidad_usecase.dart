import 'package:eos_mobile/core/data/data_source/predictive.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_predictive_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemotePredictiveUnidadUseCase implements UseCase<DataState<List<UnidadPredictiveEntity>>, Predictive> {
  RemotePredictiveUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<List<UnidadPredictiveEntity>>> call({required Predictive params}) async {
    return _unidadRepository.predictive(params);
  }
}
