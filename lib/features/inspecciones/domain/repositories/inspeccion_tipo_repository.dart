import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_req_entity.dart';

abstract class InspeccionTipoRepository {
  /// API METHODS
  Future<DataState<List<InspeccionTipoEntity>>> listInspeccionesTipos();
  Future<DataState<ApiResponseEntity>> storeInspeccionTipo(InspeccionTipoReqEntity inspeccionTipo);
  Future<DataState<ApiResponseEntity>> updateInspeccionTipo(InspeccionTipoEntity inspeccionTipo);
  Future<DataState<ApiResponseEntity>> deleteInspeccionTipo(InspeccionTipoEntity inspeccionTipo);

  /// LOCAL METHODS
}
