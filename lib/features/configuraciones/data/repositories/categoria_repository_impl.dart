import 'dart:io';

import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/data/datasources/remote/categorias/categoria_api_service.dart';
import 'package:eos_mobile/features/configuraciones/data/models/categorias/categoria_model.dart';
import 'package:eos_mobile/features/configuraciones/data/models/categorias/categoria_req_model.dart';
import 'package:eos_mobile/features/configuraciones/data/models/inspecciones_tipos/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/categoria_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaRepositoryImpl implements CategoriaRepository {
  CategoriaRepositoryImpl(this._categoriaApiService);

  final CategoriaApiService _categoriaApiService;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<DataState<List<CategoriaModel>>> fetchCategoriasByIdInspeccionTipo(InspeccionTipoEntity inspeccionTipo) async {
    try {
      final String? retrieveToken = await _secureStorage.read(key: 'token');
      final httpResponse = await _categoriaApiService.fetchCategoriasByIdInspeccionTipo(
        'Bearer $retrieveToken',
        'application/json',
        InspeccionTipoModel.fromEntity(inspeccionTipo),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ApiResponse apiResponse = httpResponse.data;
        final dynamic resultMap = apiResponse.result;

        // ignore: avoid_dynamic_calls
        final List<dynamic> lstResult = resultMap['categorias'] as List<dynamic>;

        final List<CategoriaModel> objCategorias = lstResult
            .map<CategoriaModel>(
              (dynamic i) => CategoriaModel.fromJson(i as Map<String, dynamic>),
            ).toList();

        return DataSuccess(objCategorias);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }

  @override
  Future<DataState<ApiResponse>> createCategoria(CategoriaReqEntity categoriaReq) async {
    try {
      final String? retrieveToken = await _secureStorage.read(key: 'token');
      final httpResponse = await _categoriaApiService.createCategoria(
        'Bearer $retrieveToken',
        'application/json',
        CategoriaReqModel.fromEntity(categoriaReq),
      );

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
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }

  @override
  Future<DataState<ApiResponse>> updateCategoria(CategoriaReqEntity categoriaReq) async {
    try {
      final String? retrieveToken = await _secureStorage.read(key: 'token');
      final httpResponse = await _categoriaApiService.updateCategoria(
        'Bearer $retrieveToken',
        'application/json',
        CategoriaReqModel.fromEntity(categoriaReq),
      );

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
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }

  @override
  Future<DataState<ApiResponse>> deleteCategoria(CategoriaEntity categoria) async {
    try {
      final String? retrieveToken = await _secureStorage.read(key: 'token');
      final httpResponse = await _categoriaApiService.deleteCategoria(
        'Bearer $retrieveToken',
        'application/json',
        CategoriaModel.fromEntity(categoria),
      );

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
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }
}
