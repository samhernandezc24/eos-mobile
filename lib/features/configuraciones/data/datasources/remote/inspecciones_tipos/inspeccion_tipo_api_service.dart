import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/features/configuraciones/data/models/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/configuraciones/data/models/inspeccion_tipo_req_model.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:retrofit/retrofit.dart';

part 'inspeccion_tipo_api_service.g.dart';

@RestApi(baseUrl: ListAPI.inspeccionesTipos)
abstract class InspeccionTipoApiService {
  factory InspeccionTipoApiService(Dio dio) = _InspeccionTipoApiService;

  // LISTADO DE INSPECCIONES TIPOS
  @POST('/List')
  Future<HttpResponse<ApiResponse>> fetchInspeccionesTipos(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
  );

  // CREACIÓN DE INSPECCIONES TIPOS
  @POST('/Store')
  Future<HttpResponse<ApiResponse>> createInspeccionTipo(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() InspeccionTipoReqModel inspeccionTipoReq,
  );

  // ACTUALIZACIÓN DE INSPECCIONES TIPOS
  @POST('/Update')
  Future<HttpResponse<ApiResponse>> updateInspeccionTipo(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() InspeccionTipoReqModel inspeccionTipoReq,
  );

  // ELIMINACIÓN DE INSPECCIONES TIPOS
  @POST('/Delete')
  Future<HttpResponse<ApiResponse>> deleteInspeccionTipo(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() InspeccionTipoModel inspeccionTipo,
  );
}
