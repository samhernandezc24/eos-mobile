import 'dart:io';

import 'package:eos_mobile/features/inspecciones/data/datasources/remote/categoria_item/categoria_item_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_data_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_duplicate_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class CategoriaItemRepositoryImpl implements CategoriaItemRepository {
  CategoriaItemRepositoryImpl(this._categoriaItemRemoteApiService);

  final CategoriaItemRemoteApiService _categoriaItemRemoteApiService;

  /// LISTADO DE CATEGORIAS ITEMS
  @override
  Future<DataState<CategoriaItemDataModel>> list(CategoriaEntity objData) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaItemRemoteApiService.list('application/json', 'Bearer $token', CategoriaModel.fromEntity(objData));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session!) {
          if (objResponse.action!) {
            // ignore: avoid_dynamic_calls
            final result = objResponse.result['categoriasItems'] as Map<String, dynamic>;
            final CategoriaItemDataModel objCategoriaItem = CategoriaItemDataModel.fromJson(result);

            return DataSuccess(objCategoriaItem);
          } else {
            return DataFailedMessage(objResponse.message ?? 'Error inesperado');
          }
        } else {
          return DataFailedMessage(objResponse.message ?? 'Error inesperado');
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
  Future<DataState<ServerResponse>> store(CategoriaItemStoreReqEntity objData) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaItemRemoteApiService.store(
        'application/json',
        'Bearer $token',
        CategoriaItemStoreReqModel.fromEntity(objData),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session!) {
          if (objResponse.action!) {
            return DataSuccess(objResponse);
          } else {
            return DataFailedMessage(objResponse.message ?? 'Error inesperado');
          }
        } else {
          return DataFailedMessage(objResponse.message ?? 'Error inesperado');
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

  /// GUARDADO DE CATEGORIA ITEM DUPLICADA
  @override
  Future<DataState<ServerResponse>> storeDuplicate(CategoriaItemDuplicateReqEntity objData) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaItemRemoteApiService.storeDuplicate(
        'application/json',
        'Bearer $token',
        CategoriaItemDuplicateReqModel.fromEntity(objData),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session!) {
          if (objResponse.action!) {
            return DataSuccess(objResponse);
          } else {
            return DataFailedMessage(objResponse.message ?? 'Error inesperado');
          }
        } else {
          return DataFailedMessage(objResponse.message ?? 'Error inesperado');
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

  /// ACTUALIZACIÓN DE CATEGORIA ITEM
  @override
  Future<DataState<ServerResponse>> update(CategoriaItemEntity objData) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaItemRemoteApiService.update(
        'application/json',
        'Bearer $token',
        CategoriaItemModel.fromEntity(objData),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session!) {
          if (objResponse.action!) {
            return DataSuccess(objResponse);
          } else {
            return DataFailedMessage(objResponse.message ?? 'Error inesperado');
          }
        } else {
          return DataFailedMessage(objResponse.message ?? 'Error inesperado');
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

  /// ELIMINACIÓN DE CATEGORIA ITEM
  @override
  Future<DataState<ServerResponse>> delete(CategoriaItemEntity objData) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaItemRemoteApiService.delete(
        'application/json',
        'Bearer $token',
        CategoriaItemModel.fromEntity(objData),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session!) {
          if (objResponse.action!) {
            return DataSuccess(objResponse);
          } else {
            return DataFailedMessage(objResponse.message ?? 'Error inesperado');
          }
        } else {
          return DataFailedMessage(objResponse.message ?? 'Error inesperado');
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
}
