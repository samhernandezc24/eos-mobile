import 'package:eos_mobile/core/constants/api_endpoints.dart';
import 'package:eos_mobile/core/data/data_source/data_source.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_store_req_model.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:retrofit/retrofit.dart';

part 'inspeccion_remote_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.inspecciones)
abstract class InspeccionRemoteApiService {
  factory InspeccionRemoteApiService(Dio dio, {String baseUrl}) = _InspeccionRemoteApiService;

  /// OBTENER DATOS PARA LISTA DE INSPECCIONES
  @POST('/Index')
  Future<HttpResponse<IReturn>> index();

  /// OBTENER DATOS DINAMICOS DE INSPECCIONES
  @POST('/DataSource')
  Future<HttpResponse<IReturn>> dataSource(@Body() DataSource objData);

  /// OBTENER DATOS PARA CREAR INSPECCION
  @POST('/Create')
  Future<HttpResponse<IReturn>> create();

  /// GUARDAR INSPECCION
  @POST('/Store')
  Future<HttpResponse<IReturn>> store(@Body() InspeccionStoreReqModel objData);

  /// CANCELAR INSPECCION
  @POST('/Cancel')
  Future<HttpResponse<IReturn>> cancel(@Body() InspeccionIdParamModel objData);
}
