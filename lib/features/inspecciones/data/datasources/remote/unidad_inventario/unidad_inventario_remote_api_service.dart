import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/data/predictive_search_req_data.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:retrofit/retrofit.dart';

part 'unidad_inventario_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.unidadesEOS)
abstract class UnidadInventarioRemoteApiService {
  factory UnidadInventarioRemoteApiService(Dio dio, {String baseUrl}) = _UnidadInventarioRemoteApiService;

  /// BUSCADOR PREDICTIVO
  @POST('/PredictiveEOS')
  Future<HttpResponse<ApiResponse>> predictiveUnidadInventario(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() PredictiveSearchReqModel predictiveSearch,
  );
}