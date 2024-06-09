import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:retrofit/retrofit.dart';

part 'data_source_persistence_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.dataSourcePersistence)
abstract class DataSourcePersistenceRemoteApiService {
  factory DataSourcePersistenceRemoteApiService(Dio dio, {String baseUrl}) = _DataSourcePersistenceRemoteApiService;

  /// ACTUALIZAR EL DATA SOURCE PERSISTENCE DEL USUARIO
  @POST('/Update')
  Future<HttpResponse<ServerResponse>> update(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() DataSourcePersistence varArgs,
  );
}
