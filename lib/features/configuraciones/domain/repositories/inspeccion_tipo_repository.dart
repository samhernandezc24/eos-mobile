import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_req_entity.dart';

abstract class InspeccionTipoRepository {
  /// API METHODS
  Future<DataState<List<InspeccionTipoEntity>>> fetchInspeccionesTipos();
  Future<DataState<ApiResponseEntity>> createInspeccionTipo(InspeccionTipoReqEntity inspeccionTipoReq);
  Future<DataState<ApiResponseEntity>> updateInspeccionTipo(InspeccionTipoReqEntity inspeccionTipoReq);
  Future<DataState<ApiResponseEntity>> deleteInspeccionTipo(InspeccionTipoEntity inspeccionTipo);
  Future<DataState<ApiResponseEntity>> updateOrdenInspeccionTipo(List<Map<String, dynamic>> inspeccionesTipos);
}
