// ignore_for_file: avoid_dynamic_calls

import 'dart:io';

import 'package:eos_mobile/core/data/catalogos_data/unidad_data.dart';
import 'package:eos_mobile/core/data/predictive_search_req_data.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/network/errors/exceptions.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/unidad/unidad_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_predictive_data_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadRepositoryImpl implements UnidadRepository {
  UnidadRepositoryImpl(this._unidadRemoteApiService);

  final UnidadRemoteApiService _unidadRemoteApiService;

  /// CREACIÓN DE UNIDAD
  @override
  Future<DataState<UnidadDataModel>> createUnidad() async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _unidadRemoteApiService.createUnidad('Bearer $token', 'application/json');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ApiResponse apiResponse = httpResponse.data;

        if (httpResponse.data.session) {
          if (httpResponse.data.action) {
            final result = apiResponse.result as Map<String, dynamic>;
            final UnidadDataModel objUnidadData = UnidadDataModel.fromJson(result);

            return DataSuccess(objUnidadData);
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

  /// GUARDADO DE UNIDAD
  @override
  Future<DataState<ApiResponse>> storeUnidad(UnidadReqEntity unidad) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _unidadRemoteApiService.storeUnidad(
        'Bearer $token',
        'application/json',
        UnidadReqModel.fromEntity(unidad),
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

  /// BUSCADOR PREDICTIVO DE UNIDAD (TEMPORAL)
  @override
  Future<DataState<UnidadPredictiveDataModel>> predictiveUnidad(PredictiveSearchReqEntity predictiveSearch) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _unidadRemoteApiService.predictiveUnidad(
        'Bearer $token',
        'application/json',
        PredictiveSearchReqModel.fromEntity(predictiveSearch),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ApiResponse apiResponse = httpResponse.data;

        if (httpResponse.data.session) {
          if (httpResponse.data.action) {
            final result = apiResponse.result as Map<String, dynamic>;
            final UnidadPredictiveDataModel objUnidad = UnidadPredictiveDataModel.fromJson(result);

            return DataSuccess(objUnidad);
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
