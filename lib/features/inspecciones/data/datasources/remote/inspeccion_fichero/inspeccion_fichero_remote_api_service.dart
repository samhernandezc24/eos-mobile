import 'package:eos_mobile/core/constants/api_endpoints.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_fichero/inspeccion_fichero_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_fichero/inspeccion_fichero_store_req_model.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';
import 'package:retrofit/retrofit.dart';

part 'inspeccion_fichero_remote_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.inspeccionesFicheros)
abstract class InspeccionFicheroRemoteApiService {
  factory InspeccionFicheroRemoteApiService(Dio dio, {String baseUrl}) = _InspeccionFicheroRemoteApiService;

  /// LISTA DE FICHEROS
  @POST('/List')
  Future<HttpResponse<IReturn>> list(@Body() InspeccionIdParamModel objData);

  /// GUARDAR FICHERO
  @POST('/Store')
  Future<HttpResponse<IReturn>> store(@Body() InspeccionFicheroStoreReqModel objData);

  /// ELIMINAR FICHERO
  @POST('/Delete')
  Future<HttpResponse<IReturn>> delete(@Body() InspeccionFicheroIdParamModel objData);
}
