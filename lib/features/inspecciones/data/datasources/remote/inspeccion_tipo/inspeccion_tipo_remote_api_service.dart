import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:retrofit/retrofit.dart';

part 'inspeccion_tipo_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.inspeccionesTipos)
abstract class InspeccionTipoRemoteApiService {
  factory InspeccionTipoRemoteApiService(Dio dio, {String baseUrl}) = _InspeccionTipoRemoteApiService;

  // LISTADO DE INSPECCIONES TIPOS
  @POST('/List')
  Future<HttpResponse<ApiResponse>> listInspeccionesTipos(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
  );
}
