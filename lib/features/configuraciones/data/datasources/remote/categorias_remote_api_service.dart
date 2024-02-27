import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/features/configuraciones/data/models/categoria_model.dart';
import 'package:eos_mobile/features/configuraciones/data/models/inspeccion_req_model.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:retrofit/retrofit.dart';

part 'categorias_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.categorias)
abstract class CategoriasRemoteApiService {
  factory CategoriasRemoteApiService(Dio dio) = _CategoriasRemoteApiService;

  // LISTADO DE CATEGORIAS
  @POST('/List')
  Future<HttpResponse<List<CategoriaModel>>> getCategorias(
    @Header(HttpHeaders.authorizationHeader) String token,
  );

  // LISTADO DE CATEGORIAS POR ID DE INSPECCION
  @POST('/ListByIdInspeccion')
  Future<HttpResponse<List<CategoriaModel>>> getCategoriasByIdInspeccion(
    @Header(HttpHeaders.authorizationHeader) String token,
    @Body() InspeccionReqModel idInspeccion,
  );
}
