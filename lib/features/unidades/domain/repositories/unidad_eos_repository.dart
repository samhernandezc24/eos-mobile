import 'package:eos_mobile/core/data/predictive.dart';
import 'package:eos_mobile/features/unidades/domain/entities/unidad/unidad_eos_predictive_list_entity.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class UnidadEOSRepository {
  // API METHODS
  Future<DataState<List<UnidadEOSPredictiveListEntity>>> predictiveEOS(Predictive varArgs);

  // LOCAL METHODS
}
