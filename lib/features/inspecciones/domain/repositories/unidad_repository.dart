import 'package:eos_mobile/core/common/data/catalogos/predictive_search_req.dart';
import 'package:eos_mobile/core/common/data/catalogos/unidad_data.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_inventario_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_req_entity.dart';

abstract class UnidadRepository {
  /// API METHODS (INVENTARIO)
  Future<DataState<UnidadInventarioEntity>> predictiveUnidadInventario(PredictiveSearchReqEntity predictiveSearch);

  /// API METHODS (TEMPORAL)
  Future<DataState<UnidadDataEntity>> createUnidad();
  Future<DataState<ApiResponseEntity>> storeUnidad(UnidadReqEntity unidad);

  /// LOCAL METHODS
}
