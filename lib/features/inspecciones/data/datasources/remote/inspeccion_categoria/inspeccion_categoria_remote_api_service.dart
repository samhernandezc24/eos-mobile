import 'package:eos_mobile/core/constants/api_endpoints.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_categoria/inspeccion_categoria_store_req_model.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';
import 'package:retrofit/retrofit.dart';

part 'inspeccion_categoria_remote_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.inspeccionesCategorias)
abstract class InspeccionCategoriaRemoteApiService {
  factory InspeccionCategoriaRemoteApiService(Dio dio, {String baseUrl}) = _InspeccionCategoriaRemoteApiService;

  /// OBTENER PREGUNTAS
  @POST('/GetPreguntas')
  Future<HttpResponse<IReturn>> getPreguntas(@Body() InspeccionIdParamModel objData);

  /// GUARDAR EVALUACION
  @POST('/Store')
  Future<HttpResponse<IReturn>> store(@Body() InspeccionCategoriaStoreReqModel objData);
}
