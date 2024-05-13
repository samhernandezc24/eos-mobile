import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_duplicate_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_store_req_model.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:retrofit/retrofit.dart';

part 'categoria_item_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.categoriasItems)
abstract class CategoriaItemRemoteApiService {
  factory CategoriaItemRemoteApiService(Dio dio, {String baseUrl}) = _CategoriaItemRemoteApiService;

  /// LISTA DE CATEGORIAS ITEMS
  @POST('/List')
  Future<HttpResponse<ServerResponse>> list(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaModel objData,
  );

  /// GUARDAR CATEGORIA ITEM
  @POST('/Store')
  Future<HttpResponse<ServerResponse>> store(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaItemStoreReqModel objData,
  );

  /// GUARDAR CATEGORIA ITEM DUPLICADO
  @POST('/StoreDuplicate')
  Future<HttpResponse<ServerResponse>> storeDuplicate(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaItemDuplicateReqModel objData,
  );

  /// ACTUALIZAR CATEGORIA ITEM
  @POST('/Update')
  Future<HttpResponse<ServerResponse>> update(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaItemModel objData,
  );

  /// ELIMINAR CATEGORIA ITEM
  @POST('/Delete')
  Future<HttpResponse<ServerResponse>> delete(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaItemModel objData,
  );
}
