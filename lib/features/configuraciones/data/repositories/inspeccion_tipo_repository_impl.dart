import 'dart:io';

import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/data/datasources/remote/inspecciones_tipos/inspeccion_tipo_api_service.dart';
import 'package:eos_mobile/features/configuraciones/data/models/inspecciones_tipos/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/configuraciones/data/models/inspecciones_tipos/inspeccion_tipo_req_model.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_tipo_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionTipoRepositoryImpl implements InspeccionTipoRepository {
  InspeccionTipoRepositoryImpl(this._inspeccionTipoApiService);

  final InspeccionTipoApiService _inspeccionTipoApiService;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<DataState<List<InspeccionTipoModel>>> fetchInspeccionesTipos() async {
    try {
      final String? retrieveToken = await _secureStorage.read(key: 'token');
      final httpResponse = await _inspeccionTipoApiService.fetchInspeccionesTipos(
        'Bearer $retrieveToken',
        'application/json',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ApiResponse apiResponse = httpResponse.data;
        final dynamic resultMap = apiResponse.result;

        // ignore: avoid_dynamic_calls
        final List<dynamic> lstResult = resultMap['inspeccionesTipos'] as List<dynamic>;

        final List<InspeccionTipoModel> objInspeccionesTipos = lstResult
            .map<InspeccionTipoModel>(
              (dynamic i) =>
                  InspeccionTipoModel.fromJson(i as Map<String, dynamic>),
            )
            .toList();

        return DataSuccess(objInspeccionesTipos);
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
  Future<DataState<ApiResponse>> createInspeccionTipo(InspeccionTipoReqEntity inspeccionTipoReq) async {
    try {
      final String? retrieveToken = await _secureStorage.read(key: 'token');
      final httpResponse = await _inspeccionTipoApiService.createInspeccionTipo(
        'Bearer $retrieveToken',
        'application/json',
        InspeccionTipoReqModel.fromEntity(inspeccionTipoReq),
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
  Future<DataState<ApiResponse>> updateInspeccionTipo(InspeccionTipoReqEntity inspeccionTipoReq) async {
    try {
      final String? retrieveToken = await _secureStorage.read(key: 'token');

      final httpResponse = await _inspeccionTipoApiService.updateInspeccionTipo(
        'Bearer $retrieveToken',
        'application/json',
        InspeccionTipoReqModel.fromEntity(inspeccionTipoReq),
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
  Future<DataState<ApiResponse>> updateOrdenInspeccionTipo(List<Map<String, dynamic>> inspeccionesTipos) async {
    try {
      final String? retrieveToken = await _secureStorage.read(key: 'token');

      final httpResponse = await _inspeccionTipoApiService.updateOrdenInspeccionTipo(
        'Bearer $retrieveToken',
        'application/json',
        inspeccionesTipos,
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
  Future<DataState<ApiResponse>> deleteInspeccionTipo(InspeccionTipoEntity inspeccionTipo) async {
    try {
      final String? retrieveToken = await _secureStorage.read(key: 'token');
      final httpResponse = await _inspeccionTipoApiService.deleteInspeccionTipo(
        'Bearer $retrieveToken',
        'application/json',
        InspeccionTipoModel.fromEntity(inspeccionTipo),
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
