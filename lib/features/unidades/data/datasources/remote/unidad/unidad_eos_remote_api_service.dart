import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/data/predictive.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:retrofit/retrofit.dart';

part 'unidad_eos_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.unidadesEOS)
abstract class UnidadEOSRemoteApiService {
  factory UnidadEOSRemoteApiService(Dio dio, {String baseUrl}) = _UnidadEOSRemoteApiService;

  /// PREDICTIVO DE UNIDADES EOS
  @POST('/PredictiveEOS')
  Future<HttpResponse<ServerResponse>> predictiveEOS(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() Predictive varArgs,
  );
}
