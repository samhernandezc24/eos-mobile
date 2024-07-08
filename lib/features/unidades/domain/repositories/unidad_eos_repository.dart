import 'package:eos_mobile/features/unidades/domain/entities/unidad/unidad_eos_predictive_entity.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

abstract class UnidadEOSRepository {
  // REMOTE OPERATIONS
  Future<DataState<List<UnidadEOSPredictiveEntity>>> predictiveEOS(Predictive varArgs);

  // LOCAL OPERATIONS
}
