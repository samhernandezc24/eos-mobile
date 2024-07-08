import 'package:eos_mobile/core/constants/api_endpoints.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';
import 'package:retrofit/retrofit.dart';

part 'data_source_persistence_remote_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.dataSourcePersistence)
abstract class DataSourcePersistenceRemoteApiService {
  factory DataSourcePersistenceRemoteApiService(Dio dio, {String baseUrl}) = _DataSourcePersistenceRemoteApiService;

  /// ACTUALIZAR LA PERSISTENCIA DE DATOS
  @POST('/Update')
  Future<HttpResponse<IReturn>> update(@Body() DataSourcePersistence varArgs);
}
