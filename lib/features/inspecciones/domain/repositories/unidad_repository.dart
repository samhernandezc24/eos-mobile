import 'package:eos_mobile/core/data/catalogos_data/unidad_data.dart';
import 'package:eos_mobile/core/data/predictive_search_req_data.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_predictive_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_req_entity.dart';

abstract class UnidadRepository {
  /// API METHODS
  Future<DataState<UnidadDataEntity>> createUnidad();
  Future<DataState<ApiResponseEntity>> storeUnidad(UnidadReqEntity unidad);
  Future<DataState<UnidadPredictiveDataEntity>> predictiveUnidad(PredictiveSearchReqEntity predictiveSearch);

  /// LOCAL METHODS
}
