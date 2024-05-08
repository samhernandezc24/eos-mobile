import 'package:eos_mobile/core/data/predictive_search_req_data.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad_inventario/unidad_inventario_data_entity.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class UnidadInventarioRepository {
  /// API METHODS
  Future<DataState<UnidadInventarioDataEntity>> predictiveUnidadInventario(PredictiveSearchReqEntity predictiveSearch);
}
