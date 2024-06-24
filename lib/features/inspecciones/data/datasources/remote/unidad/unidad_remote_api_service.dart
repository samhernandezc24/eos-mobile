import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/data/predictive.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_store_req_model.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:retrofit/retrofit.dart';

part 'unidad_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.unidades)
abstract class UnidadRemoteApiService {
  factory UnidadRemoteApiService(Dio dio, {String baseUrl}) = _UnidadRemoteApiService;

  /// CARGAR INFORMACIÓN DE LA UNIDAD
  @POST('/Index')
  Future<HttpResponse<ServerResponse>> index(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
  );

  /// DATA SOURCE DE UNIDADES
  @POST('/DataSource')
  Future<HttpResponse<ServerResponse>> dataSource(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() Map<String, dynamic> objData,
  );

  /// CARGAR INFORMACIÓN PARA CREAR UNA UNIDAD
  @POST('/Create')
  Future<HttpResponse<ServerResponse>> create(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
  );

  /// GUARDAR UNIDAD
  @POST('/Store')
  Future<HttpResponse<ServerResponse>> store(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() UnidadStoreReqModel objData,
  );

  /// LISTADO DE UNIDADES
  @POST('/List')
  Future<HttpResponse<ServerResponse>> list(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
  );

  /// PREDICTIVO DE UNIDADES
  @POST('/Predictive')
  Future<HttpResponse<ServerResponse>> predictive(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() Predictive varArgs,
  );
}
