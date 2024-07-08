import 'package:eos_mobile/core/constants/api_endpoints.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';
import 'package:retrofit/retrofit.dart';

part 'unidad_eos_remote_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.unidadesEOS)
abstract class UnidadEOSRemoteApiService {
  factory UnidadEOSRemoteApiService(Dio dio, {String baseUrl}) = _UnidadEOSRemoteApiService;

  /// PREDICTIVO DE UNIDADES EOS
  @POST('/PredictiveEOS')
  Future<HttpResponse<IReturn>> predictiveEOS(@Body() Predictive varArgs);
}
