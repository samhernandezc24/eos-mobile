import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/data/api_response_model.dart';
import 'package:eos_mobile/features/configuraciones/data/models/inspeccion_model.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:retrofit/retrofit.dart';

part 'inspecciones_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.inspecciones)
abstract class InspeccionesRemoteApiService {
  factory InspeccionesRemoteApiService(Dio dio) = _InspeccionesRemoteApiService;

  // LISTADO DE INSPECCIONES
  @POST('/List')
  Future<HttpResponse<List<InspeccionModel>>> getInspecciones(
    @Header(HttpHeaders.authorizationHeader) String token,
  );

  // CREAR Y GUARDAR UNA INSPECCION
  @POST('/Store')
  Future<HttpResponse<ApiResponseModel>> createInspeccion(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() InspeccionModel inspeccion,
  );
}
