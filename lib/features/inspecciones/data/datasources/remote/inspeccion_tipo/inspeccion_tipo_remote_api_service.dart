import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_store_req_model.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:retrofit/retrofit.dart';

part 'inspeccion_tipo_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.inspeccionesTipos)
abstract class InspeccionTipoRemoteApiService {
  factory InspeccionTipoRemoteApiService(Dio dio, {String baseUrl}) = _InspeccionTipoRemoteApiService;

  /// LISTA DE INSPECCIONES TIPOS
  @POST('/List')
  Future<HttpResponse<ServerResponse>> list(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
  );

  /// GUARDAR INSPECCION TIPO
  @POST('/Store')
  Future<HttpResponse<ServerResponse>> store(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() InspeccionTipoStoreReqModel objData,
  );

  /// ACTUALIZAR INSPECCION TIPO
  @POST('/Update')
  Future<HttpResponse<ServerResponse>> update(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() InspeccionTipoModel objData,
  );

  /// ELIMINAR INSPECCION TIPO
  @POST('/Delete')
  Future<HttpResponse<ServerResponse>> delete(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() InspeccionTipoModel objData,
  );
}
