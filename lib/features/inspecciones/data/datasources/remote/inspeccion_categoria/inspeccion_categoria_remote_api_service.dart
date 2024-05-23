import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_id_req_model.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:retrofit/retrofit.dart';

part 'inspeccion_categoria_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.inspeccionesCategorias)
abstract class InspeccionCategoriaRemoteApiService {
  factory InspeccionCategoriaRemoteApiService(Dio dio, {String baseUrl}) = _InspeccionCategoriaRemoteApiService;

  /// OBTENER LAS PREGUNTAS DE UNA INSPECCION
  @POST('/GetPreguntas')
  Future<HttpResponse<ServerResponse>> getPreguntas(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() InspeccionIdReqModel objData,
  );
}
