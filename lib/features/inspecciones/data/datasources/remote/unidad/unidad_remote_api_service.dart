import 'package:eos_mobile/core/constants/api_endpoints.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_store_req_model.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';
import 'package:retrofit/retrofit.dart';

part 'unidad_remote_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.unidades)
abstract class UnidadRemoteApiService {
  factory UnidadRemoteApiService(Dio dio, {String baseUrl}) = _UnidadRemoteApiService;

  /// OBTENER DATOS PARA CREAR UNIDAD
  @POST('/Create')
  Future<HttpResponse<IReturn>> create();

  /// GUARDAR UNIDAD
  @POST('/Store')
  Future<HttpResponse<IReturn>> store(@Body() UnidadStoreReqModel objData);

  /// PREDICTIVO DE UNIDADES
  @POST('/Predictive')
  Future<HttpResponse<IReturn>> predictive(@Body() Predictive varArgs);
}
