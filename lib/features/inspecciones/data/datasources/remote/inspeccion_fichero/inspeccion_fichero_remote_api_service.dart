import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_id_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_fichero/inspeccion_fichero_store_req_model.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:retrofit/retrofit.dart';

part 'inspeccion_fichero_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.inspeccionesFicheros)
abstract class InspeccionFicheroRemoteApiService {
  factory InspeccionFicheroRemoteApiService(Dio dio, {String baseUrl}) = _InspeccionFicheroRemoteApiService;

  /// LISTA DE LOS FICHEROS (FOTOGRAFÍAS) DE UNA INSPECCION
  @POST('/List')
  Future<HttpResponse<ServerResponse>> list(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() InspeccionIdReqModel objData,
  );

  /// GUARDAR FICHERO (FOTOGRAFÍA) DE UNA INSPECCION
  @POST('/Store')
  Future<HttpResponse<ServerResponse>> store(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() InspeccionFicheroStoreReqModel objData, {
    @SendProgress() ProgressCallback? onSendProgress,
  });
}
