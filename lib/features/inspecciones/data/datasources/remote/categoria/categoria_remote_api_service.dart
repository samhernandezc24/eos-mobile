import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_model.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:retrofit/retrofit.dart';

part 'categoria_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.categorias)
abstract class CategoriaRemoteApiService {
  factory CategoriaRemoteApiService(Dio dio, {String baseUrl}) = _CategoriaRemoteApiService;

  /// LISTA DE CATEGORIAS
  @POST('/List')
  Future<HttpResponse<ServerResponse>> list(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() InspeccionTipoModel objData,
  );

  /// GUARDAR CATEGORIA
  @POST('/Store')
  Future<HttpResponse<ServerResponse>> store(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() CategoriaStoreReqModel objData,
  );

  /// ACTUALIZAR CATEGORIA
  @POST('/Update')
  Future<HttpResponse<ServerResponse>> update(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() CategoriaModel objData,
  );

  /// ELIMINAR CATEGORIA
  @POST('/Delete')
  Future<HttpResponse<ServerResponse>> delete(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() CategoriaModel objData,
  );
}
