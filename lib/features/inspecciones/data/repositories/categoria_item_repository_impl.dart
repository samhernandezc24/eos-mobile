import 'dart:io';

import 'package:eos_mobile/features/inspecciones/data/datasources/remote/categoria_item/categoria_item_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_list_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_params_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_store_duplicate_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_update_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_params_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_update_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class CategoriaItemRepositoryImpl implements CategoriaItemRepository {
  CategoriaItemRepositoryImpl(this._categoriaItemRemoteApiService);

  final CategoriaItemRemoteApiService _categoriaItemRemoteApiService;

  // =========================================================
  // REMOTE OPERATIONS
  // =========================================================

  /// LISTADO DE CATEGORIAS ITEMS
  @override
  Future<DataState<CategoriaItemListModel>> list(CategoriaIdParamEntity objData) async {
    try {
      final httpResponse = await _categoriaItemRemoteApiService.list(CategoriaIdParamModel.fromEntity(objData));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.session ?? false) {
          if (response.action ?? false) {
            final Map<String, dynamic> resultData           = response.result as Map<String, dynamic>;
            final CategoriaItemListModel objCategoriaItem   = CategoriaItemListModel.fromJson(resultData);

            return DataSuccess(objCategoriaItem);
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

  /// GUARDADO DE CATEGORIA ITEM
  @override
  Future<DataState<IReturn>> store(CategoriaItemStoreReqEntity objData) async {
    try {
      final httpResponse = await _categoriaItemRemoteApiService.store(CategoriaItemStoreReqModel.fromEntity(objData));
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

  /// DUPLICADO DE CATEGORIAS ITEMS
  @override
  Future<DataState<IReturn>> storeDuplicate(CategoriaItemStoreDuplicateReqEntity objData) async {
    try {
      final httpResponse = await _categoriaItemRemoteApiService.storeDuplicate(CategoriaItemStoreDuplicateReqModel.fromEntity(objData));
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

  /// ACTUALIZACIÓN DE CATEGORIAS ITEMS
  @override
  Future<DataState<IReturn>> update(CategoriaItemUpdateReqEntity objData) async {
    try {
      final httpResponse = await _categoriaItemRemoteApiService.update(CategoriaItemUpdateReqModel.fromEntity(objData));
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

  /// ELIMINACIÓN DE CATEGORIAS ITEMS
  @override
  Future<DataState<IReturn>> delete(CategoriaItemParamsEntity objData) async {
    try {
      final httpResponse = await _categoriaItemRemoteApiService.delete(CategoriaItemParamsModel.fromEntity(objData));
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
