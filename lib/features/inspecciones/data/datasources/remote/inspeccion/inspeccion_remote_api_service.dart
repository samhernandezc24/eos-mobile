import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:retrofit/retrofit.dart';

part 'inspeccion_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.inspecciones)
abstract class InspeccionRemoteApiService {
  factory InspeccionRemoteApiService(Dio dio, {String baseUrl}) = _InspeccionRemoteApiService;

  /// CARGAR INFORMACIÓN PARA CREAR UNA INSPECCIÓN
  @POST('/Create')
  Future<HttpResponse<ApiResponse>> createInspeccion(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
  );
}
