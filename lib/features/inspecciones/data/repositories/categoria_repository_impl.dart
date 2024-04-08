import 'dart:io';

import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/categoria/categoria_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaRepositoryImpl implements CategoriaRepository {
  CategoriaRepositoryImpl(this._categoriaRemoteApiService);

  final CategoriaRemoteApiService _categoriaRemoteApiService;

  /// LISTADO DE CATEGORÍAS
  @override
  Future<DataState<List<CategoriaModel>>> listCategorias(InspeccionTipoEntity inspeccionTipo) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaRemoteApiService.listCategorias('Bearer $token', 'application/json', InspeccionTipoModel.fromEntity(inspeccionTipo));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ApiResponse apiResponse = httpResponse.data;
        if (httpResponse.data.session) {
          if (httpResponse.data.action) {
            final dynamic result = apiResponse.result;
            // ignore: avoid_dynamic_calls
            final List<dynamic> lstResult = result['categorias'] as List<dynamic>;
            final List<CategoriaModel> lstCategorias = lstResult
                .map<CategoriaModel>((dynamic i) => CategoriaModel.fromJson(i as Map<String, dynamic>))
                .toList();

            return DataSuccess(lstCategorias);
          } else {
            return DataFailedMessage(apiResponse.message);
          }
        } else {
          return DataFailedMessage(apiResponse.message);
        }
      } else {
        return DataFailed(
          DioException(
            error           : httpResponse.response.statusMessage,
            response        : httpResponse.response,
            type            : DioExceptionType.badResponse,
            requestOptions  : httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }

  /// GUARDADO DE CATEGORÍA
  @override
  Future<DataState<ApiResponse>> storeCategoria(CategoriaReqEntity categoria) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaRemoteApiService.storeCategoria('Bearer $token', 'application/json', CategoriaReqModel.fromEntity(categoria));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if (httpResponse.data.session) {
          if (httpResponse.data.action) {
            return DataSuccess(httpResponse.data);
          } else {
            return DataFailedMessage(httpResponse.data.message);
          }
        } else {
          return DataFailedMessage(httpResponse.data.message);
        }
      } else {
        return DataFailed(
          DioException(
            error           : httpResponse.response.statusMessage,
            response        : httpResponse.response,
            type            : DioExceptionType.badResponse,
            requestOptions  : httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }

  /// ACTUALIZACIÓN DE CATEGORÍA
  @override
  Future<DataState<ApiResponse>> updateCategoria(CategoriaEntity categoria) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaRemoteApiService.updateCategoria('Bearer $token', 'application/json', CategoriaModel.fromEntity(categoria));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if (httpResponse.data.session) {
          if (httpResponse.data.action) {
            return DataSuccess(httpResponse.data);
          } else {
            return DataFailedMessage(httpResponse.data.message);
          }
        } else {
          return DataFailedMessage(httpResponse.data.message);
        }
      } else {
        return DataFailed(
          DioException(
            error           : httpResponse.response.statusMessage,
            response        : httpResponse.response,
            type            : DioExceptionType.badResponse,
            requestOptions  : httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }

  /// ELIMINACIÓN DE CATEGORÍA
  @override
  Future<DataState<ApiResponse>> deleteCategoria(CategoriaEntity categoria) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaRemoteApiService.deleteCategoria('Bearer $token', 'application/json', CategoriaModel.fromEntity(categoria));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if (httpResponse.data.session) {
          if (httpResponse.data.action) {
            return DataSuccess(httpResponse.data);
          } else {
            return DataFailedMessage(httpResponse.data.message);
          }
        } else {
          return DataFailedMessage(httpResponse.data.message);
        }
      } else {
        return DataFailed(
          DioException(
            error           : httpResponse.response.statusMessage,
            response        : httpResponse.response,
            type            : DioExceptionType.badResponse,
            requestOptions  : httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }
}
