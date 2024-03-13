import 'dart:io';

import 'package:eos_mobile/core/data/api_response_entity.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/data/datasources/remote/categorias_remote_api_service.dart';
import 'package:eos_mobile/features/configuraciones/data/models/categoria_model.dart';
import 'package:eos_mobile/features/configuraciones/data/models/inspeccion_req_model.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/categoria_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaRepositoryImpl implements CategoriaRepository {
  CategoriaRepositoryImpl(this._categoriasRemoteApiService);

  final CategoriasRemoteApiService _categoriasRemoteApiService;

  final _secureStorage = const FlutterSecureStorage();

  @override
  Future<DataState<ApiResponseEntity>> createCategoria(
    CategoriaEntity categoria,
  ) {
    // TODO(samhernandezc24): implement createCategoria.
    throw UnimplementedError();
  }

  @override
  Future<DataState<List<CategoriaModel>>> getCategorias() async {
    try {
      // Recuperar el token almacenado
      final retrieveToken = await _secureStorage.read(key: 'access_token');
      final objResponse = await _categoriasRemoteApiService.getCategorias(
        'Bearer ${retrieveToken!}',
      );

      if (objResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(objResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: objResponse.response.statusMessage,
            response: objResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: objResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<CategoriaModel>>> getCategoriasByIdInspeccion(
    InspeccionReqEntity inspeccion,
  ) async {
    try {
      // Recuperar el token almacenado
      final retrieveToken = await _secureStorage.read(key: 'access_token');
      final idInspeccion =
          InspeccionReqModel(idInspeccion: inspeccion.idInspeccion);

      final objResponse =
          await _categoriasRemoteApiService.getCategoriasByIdInspeccion(
        'Bearer ${retrieveToken!}',
        idInspeccion,
      );

      if (objResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(objResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: objResponse.response.statusMessage,
            response: objResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: objResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
