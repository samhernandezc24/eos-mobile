import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_req_entity.dart';

abstract class InspeccionRepository {
  /// API METHODS
  Future<DataState<InspeccionDataEntity>> createInspeccion();
  Future<DataState<ApiResponseEntity>> storeInspeccion(InspeccionReqEntity inspeccion);

  /// LOCAL METHODS
}
