import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_model.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:retrofit/retrofit.dart';

part 'categoria_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.categorias)
abstract class CategoriaRemoteApiService {
  factory CategoriaRemoteApiService(Dio dio, {String baseUrl}) = _CategoriaRemoteApiService;

  /// LISTA DE CATEGORÍAS
  @POST('/List')
  Future<HttpResponse<ApiResponse>> listCategorias(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() InspeccionTipoModel inpseccionTipo,
  );

  /// GUARDAR CATEGORÍA
  @POST('/Store')
  Future<HttpResponse<ApiResponse>> storeCategoria(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaReqModel categoria,
  );

  /// ACTUALIZAR CATEGORÍA
  @POST('/Update')
  Future<HttpResponse<ApiResponse>> updateCategoria(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaModel categoria,
  );

  /// ELIMINAR CATEGORÍA
  @POST('/Delete')
  Future<HttpResponse<ApiResponse>> deleteCategoria(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaModel categoria,
  );
}
