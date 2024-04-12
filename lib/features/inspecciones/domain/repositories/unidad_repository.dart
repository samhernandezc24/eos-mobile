import 'package:eos_mobile/core/common/data/catalogos/unidad_data.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_req_entity.dart';

abstract class UnidadRepository {
  /// API METHODS
  Future<DataState<UnidadDataEntity>> createUnidad();
  Future<DataState<ApiResponseEntity>> storeUnidad(UnidadReqEntity unidad);

  /// LOCAL METHODS
}
