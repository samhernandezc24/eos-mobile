import 'package:eos_mobile/core/constants/api_endpoints.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_update_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_id_param_model.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:retrofit/retrofit.dart';

part 'categoria_remote_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.categorias)
abstract class CategoriaRemoteApiService {
  factory CategoriaRemoteApiService(Dio dio, {String baseUrl}) = _CategoriaRemoteApiService;

  /// LISTA DE CATEGORIAS
  @POST('/List')
  Future<HttpResponse<IReturn>> list(@Body() InspeccionTipoIdParamModel objData);

  /// GUARDAR CATEGORIA
  @POST('/Store')
  Future<HttpResponse<IReturn>> store(@Body() CategoriaStoreReqModel objData);

  /// ACTUALIZAR CATEGORIA
  @POST('/Update')
  Future<HttpResponse<IReturn>> update(@Body() CategoriaUpdateReqModel objData);

  /// ELIMINAR CATEGORIA
  @POST('/Delete')
  Future<HttpResponse<IReturn>> delete(@Body() CategoriaIdParamModel objData);
}
