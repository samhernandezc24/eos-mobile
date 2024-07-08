import 'dart:io';

import 'package:eos_mobile/features/inspecciones/data/datasources/remote/categoria/categoria_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_params_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_update_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_params_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_update_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class CategoriaRepositoryImpl implements CategoriaRepository {
  CategoriaRepositoryImpl(this._categoriaRemoteApiService);

  final CategoriaRemoteApiService _categoriaRemoteApiService;

  // =========================================================
  // REMOTE OPERATIONS
  // =========================================================

  /// LISTADO DE CATEGORIAS
  @override
  Future<DataState<List<CategoriaModel>>> list(InspeccionTipoIdParamEntity objData) async {
    try {
      final httpResponse = await _categoriaRemoteApiService.list(InspeccionTipoIdParamModel.fromEntity(objData));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.session ?? false) {
          if (response.action ?? false) {
            final Map<String, dynamic> resultData   = response.result as Map<String, dynamic>;
            final List<dynamic> lstCategorias       = resultData['categorias'] as List<dynamic>;
            final List<CategoriaModel> objResponse = lstCategorias
                .map<CategoriaModel>((dynamic i) => CategoriaModel.fromJson(i as Map<String, dynamic>))
                .toList();

            return DataSuccess(objResponse);
          } else {
            return DataFailedMessage(response.message ?? 'Error inesperado');
          }
        } else {
          return DataFailedMessage(response.message ?? 'Error inesperado');
        }
      } else {
        return DataFailed(
          ServerException.fromDioException(
            DioException(
              error           : httpResponse.response.statusMessage,
              response        : httpResponse.response,
              type            : DioExceptionType.badResponse,
              requestOptions  : httpResponse.response.requestOptions,
            ),
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ServerException.fromDioException(ex));
    }
  }

  /// GUARDADO DE CATEGORIA
  @override
  Future<DataState<IReturn>> store(CategoriaStoreReqEntity objData) async {
    try {
      final httpResponse = await _categoriaRemoteApiService.store(CategoriaStoreReqModel.fromEntity(objData));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if (httpResponse.data.session ?? false) {
          if (httpResponse.data.action ?? false) {
            return DataSuccess(httpResponse.data);
          } else {
            return DataFailedMessage(httpResponse.data.message ?? 'Error inesperado');
          }
        } else {
          return DataFailedMessage(httpResponse.data.message ?? 'Error inesperado');
        }
      } else {
        return DataFailed(
          ServerException.fromDioException(
            DioException(
              error           : httpResponse.response.statusMessage,
              response        : httpResponse.response,
              type            : DioExceptionType.badResponse,
              requestOptions  : httpResponse.response.requestOptions,
            ),
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ServerException.fromDioException(ex));
    }
  }

  /// ACTUALIZACIÓN DE CATEGORIA
  @override
  Future<DataState<IReturn>> update(CategoriaUpdateReqEntity objData) async {
    try {
      final httpResponse = await _categoriaRemoteApiService.update(CategoriaUpdateReqModel.fromEntity(objData));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if (httpResponse.data.session ?? false) {
          if (httpResponse.data.action ?? false) {
            return DataSuccess(httpResponse.data);
          } else {
            return DataFailedMessage(httpResponse.data.message ?? 'Error inesperado');
          }
        } else {
          return DataFailedMessage(httpResponse.data.message ?? 'Error inesperado');
        }
      } else {
        return DataFailed(
          ServerException.fromDioException(
            DioException(
              error           : httpResponse.response.statusMessage,
              response        : httpResponse.response,
              type            : DioExceptionType.badResponse,
              requestOptions  : httpResponse.response.requestOptions,
            ),
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ServerException.fromDioException(ex));
    }
  }

  /// ELIMINACIÓN DE CATEGORIA
  @override
  Future<DataState<IReturn>> delete(CategoriaParamsEntity objData) async {
    try {
      final httpResponse = await _categoriaRemoteApiService.delete(CategoriaParamsModel.fromEntity(objData));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if (httpResponse.data.session ?? false) {
          if (httpResponse.data.action ?? false) {
            return DataSuccess(httpResponse.data);
          } else {
            return DataFailedMessage(httpResponse.data.message ?? 'Error inesperado');
          }
        } else {
          return DataFailedMessage(httpResponse.data.message ?? 'Error inesperado');
        }
      } else {
        return DataFailed(
          ServerException.fromDioException(
            DioException(
              error           : httpResponse.response.statusMessage,
              response        : httpResponse.response,
              type            : DioExceptionType.badResponse,
              requestOptions  : httpResponse.response.requestOptions,
            ),
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ServerException.fromDioException(ex));
    }
  }

  // =========================================================
  // LOCAL OPERATIONS
  // =========================================================
}
