import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';

abstract class InspeccionTipoRepository {
  /// API METHODS
  Future<DataState<List<InspeccionTipoEntity>>> fetchInspeccionesTipos();
  Future<DataState<ApiResponse>> createInspeccionTipo(InspeccionTipoReqEntity inspeccionTipoReq);
  Future<DataState<ApiResponse>> updateInspeccionTipo(InspeccionTipoReqEntity inspeccionTipoReq);
  Future<DataState<ApiResponse>> deleteInspeccionTipo(InspeccionTipoEntity inspeccionTipo);
}
