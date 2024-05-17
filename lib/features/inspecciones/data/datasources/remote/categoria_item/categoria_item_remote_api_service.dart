import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_store_duplicate_req_model.dart';
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
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() CategoriaModel objData,
  );

  /// GUARDAR CATEGORIA ITEM
  @POST('/Store')
  Future<HttpResponse<ServerResponse>> store(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() CategoriaItemStoreReqModel objData,
  );

  /// GUARDAR DUPLICADO DE CATEGORIA ITEM
  @POST('/Store')
  Future<HttpResponse<ServerResponse>> storeDuplicate(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() CategoriaItemStoreDuplicateReqModel objData,
  );
}
