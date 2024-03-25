// import 'dart:io';

// import 'package:eos_mobile/core/constants/list_api.dart';
// import 'package:eos_mobile/core/network/api_response.dart';
// import 'package:eos_mobile/features/configuraciones/data/models/categorias/categoria_model.dart';
// import 'package:eos_mobile/features/configuraciones/data/models/categorias/categoria_req_model.dart';
// import 'package:eos_mobile/features/configuraciones/data/models/inspecciones_tipos/inspeccion_tipo_model.dart';
// import 'package:eos_mobile/shared/shared.dart';
// import 'package:retrofit/retrofit.dart';

// // part 'categoria_item_api_service.g.dart';

// @RestApi(baseUrl: ListAPI.categorias)
// abstract class CategoriaItemApiService {
//   // factory CategoriaItemApiService(Dio dio) = _CategoriaItemApiService;

//   // LISTADO DE CATEGORÍAS ITEMS POR EL ID DE CATEGORIA
//   @POST('/List')
//   Future<HttpResponse<ApiResponse>> fetchCategoriasByIdInspeccionTipo(
//     @Header(HttpHeaders.authorizationHeader) String token,
//     @Header(HttpHeaders.contentTypeHeader) String contentType,
//     @Body() InspeccionTipoModel inspeccionTipo,
//   );

//   // CREACIÓN DE CATEGORÍAS
//   @POST('/Store')
//   Future<HttpResponse<ApiResponse>> createCategoria(
//     @Header(HttpHeaders.authorizationHeader) String token,
//     @Header(HttpHeaders.contentTypeHeader) String contentType,
//     @Body() CategoriaReqModel categoriaReq,
//   );

//   // ACTUALIZACIÓN DE CATEGORÍAS
//   @POST('/Update')
//   Future<HttpResponse<ApiResponse>> updateCategoria(
//     @Header(HttpHeaders.authorizationHeader) String token,
//     @Header(HttpHeaders.contentTypeHeader) String contentType,
//     @Body() CategoriaReqModel categoriaReq,
//   );

//   // ELIMINACIÓN DE CATEGORÍAS
//   @POST('/Delete')
//   Future<HttpResponse<ApiResponse>> deleteCategoria(
//     @Header(HttpHeaders.authorizationHeader) String token,
//     @Header(HttpHeaders.contentTypeHeader) String contentType,
//     @Body() CategoriaModel categoria,
//   );
// }
