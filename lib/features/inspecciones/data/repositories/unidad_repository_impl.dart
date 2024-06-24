import 'dart:io';

import 'package:eos_mobile/core/data/predictive.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/unidad/unidad_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_create_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_data_source_res_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_index_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_predictive_list_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadRepositoryImpl implements UnidadRepository {
  UnidadRepositoryImpl(this._unidadRemoteApiService);

  final UnidadRemoteApiService _unidadRemoteApiService;

  /// CARGA DE INFORMACION DE UNIDAD
  @override
  Future<DataState<UnidadIndexModel>> index() async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _unidadRemoteApiService.index('application/json', 'Bearer $token');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session!) {
          if (objResponse.action!) {
            final unidadIndex = UnidadIndexModel.fromJson(objResponse.result as Map<String, dynamic>);

            return DataSuccess(unidadIndex);
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

  /// DATASOURCE DE UNIDAD
  @override
  Future<DataState<UnidadDataSourceResModel>> dataSource(Map<String, dynamic> objData) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _unidadRemoteApiService.dataSource('application/json', 'Bearer $token', objData);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session!) {
          if (objResponse.action!) {
            final unidadDataSource = UnidadDataSourceResModel.fromJson(objResponse.result as Map<String, dynamic>);

            return DataSuccess(unidadDataSource);
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

  /// OBTENCION DE INFORMACION PARA CREAR UNIDAD
  @override
  Future<DataState<UnidadCreateModel>> create() async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _unidadRemoteApiService.create('application/json', 'Bearer $token');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session!) {
          if (objResponse.action!) {
            final unidadCreate = UnidadCreateModel.fromJson(objResponse.result as Map<String, dynamic>);

            return DataSuccess(unidadCreate);
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

  /// GUARDADO DE INSPECCION
  @override
  Future<DataState<ServerResponse>> store(UnidadStoreReqEntity objData) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _unidadRemoteApiService.store('application/json', 'Bearer $token', UnidadStoreReqModel.fromEntity(objData));

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

  /// LISTADO DE UNIDADES
  @override
  Future<DataState<List<UnidadModel>>> list() async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _unidadRemoteApiService.list('application/json', 'Bearer $token');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session!) {
          if (objResponse.action!) {
            final result = objResponse.result;
            // ignore: avoid_dynamic_calls
            final List<dynamic> lstUnidades       = result['unidades'] as List<dynamic>;
            final List<UnidadModel> objUnidad     = lstUnidades
                .map<UnidadModel>((dynamic i) =>  UnidadModel.fromJson(i as Map<String, dynamic>))
                .toList();

            return DataSuccess(objUnidad);
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

  /// PREDICTIVO DE UNIDADES
  @override
  Future<DataState<List<UnidadPredictiveListModel>>> predictive(Predictive varArgs) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _unidadRemoteApiService.predictive('application/json', 'Bearer $token', varArgs);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session!) {
          if (objResponse.action!) {
            final result = objResponse.result;
            // ignore: avoid_dynamic_calls
            final List<dynamic> lstRows = result['rows'] as List<dynamic>;
            final List<UnidadPredictiveListModel> objUnidad = lstRows
                .map<UnidadPredictiveListModel>((dynamic i) => UnidadPredictiveListModel.fromJson(i as Map<String, dynamic>))
                .toList();

            return DataSuccess(objUnidad);
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
