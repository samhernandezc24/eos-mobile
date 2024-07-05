import 'package:eos_mobile/core/constants/api_endpoints.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_store_req_model.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:retrofit/retrofit.dart';

part 'inspeccion_tipo_remote_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.inspeccionesTipos)
abstract class InspeccionTipoRemoteApiService {
  factory InspeccionTipoRemoteApiService(Dio dio, {String baseUrl}) = _InspeccionTipoRemoteApiService;

  /// LISTA DE INSPECCIONES TIPOS
  @POST('/List')
  Future<HttpResponse<IReturn>> list();

  /// GUARDAR INSPECCION TIPO
  @POST('/Store')
  Future<HttpResponse<IReturn>> store(@Body() InspeccionTipoStoreReqModel objData);

  /// ACTUALIZAR INSPECCION TIPO
  @POST('/Update')
  Future<HttpResponse<IReturn>> update(@Body() InspeccionTipoModel objData);

  /// ELIMINAR INSPECCION TIPO
  @POST('/Delete')
  Future<HttpResponse<IReturn>> delete(@Body() InspeccionTipoIdParamModel objData);
}
