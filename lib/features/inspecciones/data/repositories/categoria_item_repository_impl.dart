import 'dart:io';

import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/network/errors/exceptions.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/categoria_item/categoria_item_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_data_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_duplicate_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaItemRepositoryImpl implements CategoriaItemRepository {
  CategoriaItemRepositoryImpl(this._categoriaItemRemoteApiService);

  final CategoriaItemRemoteApiService _categoriaItemRemoteApiService;

  /// LISTADO DE CATEGORÍAS ITEMS
  @override
  Future<DataState<CategoriaItemDataModel>> listCategoriasItems(CategoriaEntity categoria) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaItemRemoteApiService.listCategoriasItems(
        'Bearer $token',
        'application/json',
        CategoriaModel.fromEntity(categoria),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ApiResponse apiResponse = httpResponse.data;

        if (apiResponse.session) {
          if (apiResponse.action) {
            final result = apiResponse.result as Map<String, dynamic>;
            final CategoriaItemDataModel objCategoriaItem = CategoriaItemDataModel.fromJson(result);

            return DataSuccess(objCategoriaItem);
          } else {
            return DataFailedMessage(apiResponse.message);
          }
        } else {
          return DataFailedMessage(apiResponse.message);
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

  /// GUARDADO DE CATEGORÍA ITEM
  @override
  Future<DataState<ApiResponse>> storeCategoriaItem(CategoriaItemReqEntity categoriaItem) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaItemRemoteApiService.storeCategoriaItem(
        'Bearer $token',
        'application/json',
        CategoriaItemReqModel.fromEntity(categoriaItem),
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

  /// GUARDADO DE CATEGORÍA ITEM DUPLICADA
  @override
  Future<DataState<ApiResponse>> storeDuplicateCategoriaItem(CategoriaItemDuplicateReqEntity categoriaItem) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaItemRemoteApiService.storeDuplicateCategoriaItem(
        'Bearer $token',
        'application/json',
        CategoriaItemDuplicateReqModel.fromEntity(categoriaItem),
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

  /// ACTUALIZACIÓN DE CATEGORÍA ITEM
  @override
  Future<DataState<ApiResponse>> updateCategoriaItem(CategoriaItemEntity categoriaItem) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaItemRemoteApiService.updateCategoriaItem(
        'Bearer $token',
        'application/json',
        CategoriaItemModel.fromEntity(categoriaItem),
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

  /// ELIMINACIÓN DE CATEGORÍA ITEM
  @override
  Future<DataState<ApiResponse>> deleteCategoriaItem(CategoriaItemEntity categoriaItem) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaItemRemoteApiService.deleteCategoriaItem(
        'Bearer $token',
        'application/json',
        CategoriaItemModel.fromEntity(categoriaItem),
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
