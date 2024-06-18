import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/data/data_source.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_finish_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_id_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_store_req_model.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:retrofit/retrofit.dart';

part 'inspeccion_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.inspecciones)
abstract class InspeccionRemoteApiService {
  factory InspeccionRemoteApiService(Dio dio, {String baseUrl}) = _InspeccionRemoteApiService;

  /// CARGAR INFORMACIÓN DE LA INSPECCION
  @POST('/Index')
  Future<HttpResponse<ServerResponse>> index(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
  );

  /// DATA SOURCE DE INSPECCIONES
  @POST('/DataSource')
  Future<HttpResponse<ServerResponse>> dataSource(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() DataSource objData,
  );

  /// CARGAR INFORMACIÓN PARA CREAR UNA INSPECCION
  @POST('/Create')
  Future<HttpResponse<ServerResponse>> create(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
  );

  /// GUARDAR INSPECCION
  @POST('/Store')
  Future<HttpResponse<ServerResponse>> store(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() InspeccionStoreReqModel objData,
  );

  /// FINALIZAR INSPECCION
  @POST('/Finish')
  Future<HttpResponse<ServerResponse>> finish(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() InspeccionFinishReqModel objData,
  );

  /// CANCELAR INSPECCION
  @POST('/Cancel')
  Future<HttpResponse<ServerResponse>> cancel(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() InspeccionIdReqModel objData,
  );
}
