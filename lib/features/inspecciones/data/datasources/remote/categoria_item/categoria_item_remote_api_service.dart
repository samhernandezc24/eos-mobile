import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_duplicate_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_req_model.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:retrofit/retrofit.dart';

part 'categoria_item_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.categoriasItems)
abstract class CategoriaItemRemoteApiService {
  factory CategoriaItemRemoteApiService(Dio dio, {String baseUrl}) = _CategoriaItemRemoteApiService;

  /// LISTA DE CATEGORÍAS ITEMS
  @POST('/List')
  Future<HttpResponse<ApiResponse>> listCategoriasItems(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaModel categoria,
  );

  /// GUARDAR CATEGORÍA ITEM
  @POST('/Store')
  Future<HttpResponse<ApiResponse>> storeCategoriaItem(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaItemReqModel categoriaItem,
  );

  /// GUARDAR CATEGORÍA ITEM DUPLICADO
  @POST('/StoreDuplicate')
  Future<HttpResponse<ApiResponse>> storeDuplicateCategoriaItem(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaItemDuplicateReqModel categoriaItem,
  );

  /// ACTUALIZAR CATEGORÍA ITEM
  @POST('/Update')
  Future<HttpResponse<ApiResponse>> updateCategoriaItem(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaItemModel categoriaItem,
  );

  /// ACTUALIZAR CATEGORÍA ITEM
  @POST('/Delete')
  Future<HttpResponse<ApiResponse>> deleteCategoriaItem(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() CategoriaItemModel categoriaItem,
  );
}
