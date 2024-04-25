import 'dart:io';

import 'package:eos_mobile/core/common/data/catalogos/predictive_search_req.dart';
import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_req_model.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:retrofit/retrofit.dart';

part 'unidad_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.unidades)
abstract class UnidadRemoteApiService {
  factory UnidadRemoteApiService(Dio dio, {String baseUrl}) = _UnidadRemoteApiService;

  /// CREAR UNIDAD
  @POST('/Create')
  Future<HttpResponse<ApiResponse>> createUnidad(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
  );

  /// GUARDAR UNIDAD
  @POST('/Store')
  Future<HttpResponse<ApiResponse>> storeUnidad(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() UnidadReqModel unidad,
  );

  /// BUSCADOR PREDICTIVO
  @POST('/PredictiveEOS')
  Future<HttpResponse<ApiResponse>> predictiveUnidad(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() PredictiveSearchReqModel predictiveSearch,
  );
}
