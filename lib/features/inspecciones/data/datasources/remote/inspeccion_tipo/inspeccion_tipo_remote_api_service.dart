import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_req_model.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:retrofit/retrofit.dart';

part 'inspeccion_tipo_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.inspeccionesTipos)
abstract class InspeccionTipoRemoteApiService {
  factory InspeccionTipoRemoteApiService(Dio dio, {String baseUrl}) = _InspeccionTipoRemoteApiService;

  /// LISTA DE INSPECCIONES TIPOS
  @POST('/List')
  Future<HttpResponse<ApiResponse>> listInspeccionesTipos(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
  );

  /// GUARDAR INSPECCIÓN TIPO
  @POST('/Store')
  Future<HttpResponse<ApiResponse>> storeInspeccionTipo(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() InspeccionTipoReqModel inspeccionTipo,
  );

  /// ACTUALIZAR INSPECCIÓN TIPO
  @POST('/Update')
  Future<HttpResponse<ApiResponse>> updateInspeccionTipo(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() InspeccionTipoModel inspeccionTipo,
  );

  /// ELIMINAR INSPECCIÓN TIPO
  @POST('/Delete')
  Future<HttpResponse<ApiResponse>> deleteInspeccionTipo(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() InspeccionTipoModel inspeccionTipo,
  );
}
