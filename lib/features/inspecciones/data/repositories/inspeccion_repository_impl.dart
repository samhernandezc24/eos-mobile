import 'dart:io';

import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion/inspeccion_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_data_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_data_source_res_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionRepositoryImpl implements InspeccionRepository {
  InspeccionRepositoryImpl(this._inspeccionRemoteApiService);

  final InspeccionRemoteApiService _inspeccionRemoteApiService;

  /// CREACIÓN DE UNA INSPECCIÓN
  @override
  Future<DataState<InspeccionDataModel>> createInspeccion() async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _inspeccionRemoteApiService.createInspeccion('Bearer $token', 'application/json');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ApiResponse apiResponse = httpResponse.data;

        if (apiResponse.session) {
          if (apiResponse.action) {
            final result = apiResponse.result as Map<String, dynamic>;
            final InspeccionDataModel objInspeccion = InspeccionDataModel.fromJson(result);

            return DataSuccess(objInspeccion);
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

  /// GUARDADO DE INSPECCIÓN
  @override
  Future<DataState<ApiResponse>> storeInspeccion(InspeccionReqEntity inspeccion) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _inspeccionRemoteApiService.storeInspeccion(
        'Bearer $token',
        'application/json',
        InspeccionReqModel.fromEntity(inspeccion),
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

  /// DATA SOURCE DE INSPECCIONES
  @override
  Future<DataState<InspeccionDataSourceResModel>> dataSourceInspeccion(Map<String, dynamic> objData) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _inspeccionRemoteApiService.dataSourceInspeccion(
        'Bearer $token',
        'application/json',
        objData,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ApiResponse apiResponse = httpResponse.data;
        if (httpResponse.data.session) {
          if (httpResponse.data.action) {
            final result = apiResponse.result as Map<String, dynamic>;
            final InspeccionDataSourceResModel dataSource = InspeccionDataSourceResModel.fromJson(result);

            return DataSuccess(dataSource);
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
