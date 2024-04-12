import 'dart:io';

import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/categoria_item/categoria_item_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaItemRepositoryImpl implements CategoriaItemRepository {
  CategoriaItemRepositoryImpl(this._categoriaItemRemoteApiService);

  final CategoriaItemRemoteApiService _categoriaItemRemoteApiService;

  /// LISTADO DE CATEGORÍAS ITEMS
  @override
  Future<DataState<List<CategoriaItemModel>>> listCategoriasItems(CategoriaEntity categoria) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaItemRemoteApiService.listCategoriasItems('Bearer $token', 'application/json', CategoriaModel.fromEntity(categoria));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ApiResponse apiResponse = httpResponse.data;
        if (httpResponse.data.session) {
          if (httpResponse.data.action) {
            final dynamic result = apiResponse.result;
            // ignore: avoid_dynamic_calls
            final List<dynamic> lstResult = result['categoriasItems'] as List<dynamic>;
            final List<CategoriaItemModel> lstCategoriasItems = lstResult
                .map<CategoriaItemModel>((dynamic i) => CategoriaItemModel.fromJson(i as Map<String, dynamic>))
                .toList();

            return DataSuccess(lstCategoriasItems);
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

  /// GUARDADO DE CATEGORÍA ITEM
  @override
  Future<DataState<ApiResponse>> storeCategoriaItem(CategoriaItemReqEntity categoriaItem) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _categoriaItemRemoteApiService.storeCategoriaItem('Bearer $token', 'application/json', CategoriaItemReqModel.fromEntity(categoriaItem));

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

  @override
  Future<DataState<ApiResponse>> updateCategoriaItem(CategoriaItemEntity categoriaItem) {
    // TODO: implement updateCategoriaItem
    throw UnimplementedError();
  }

  @override
  Future<DataState<ApiResponse>> deleteCategoriaItem(CategoriaItemEntity categoriaItem) {
    // TODO: implement deleteCategoriaItem
    throw UnimplementedError();
  }
}