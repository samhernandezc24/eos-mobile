import 'dart:io';

import 'package:eos_mobile/features/inspecciones/data/datasources/remote/unidad/unidad_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_create_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_predictive_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class UnidadRepositoryImpl implements UnidadRepository {
  UnidadRepositoryImpl(this._unidadRemoteApiService);

  final UnidadRemoteApiService _unidadRemoteApiService;

  // =========================================================
  // REMOTE OPERATIONS
  // =========================================================

  /// OBTENCIÓN DE DATOS PARA CREAR UNIDAD
  @override
  Future<DataState<UnidadCreateModel>> create() async {
    try {
      final httpResponse = await _unidadRemoteApiService.create();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.session ?? false) {
          if (response.action ?? false) {
            final Map<String, dynamic> resultData     = response.result as Map<String, dynamic>;
            final UnidadCreateModel objUnidadCreate   = UnidadCreateModel.fromJson(resultData);

            return DataSuccess(objUnidadCreate);
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

  /// GUARDADO DE UNIDAD
  @override
  Future<DataState<IReturn>> store(UnidadStoreReqEntity objData) async {
    try {
      final httpResponse = await _unidadRemoteApiService.store(UnidadStoreReqModel.fromEntity(objData));
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

  /// PREDICTIVO DE UNIDADES
  @override
  Future<DataState<List<UnidadPredictiveModel>>> predictive(Predictive varArgs) async {
    try {
      final httpResponse = await _unidadRemoteApiService.predictive(varArgs);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.session ?? false) {
          if (response.action ?? false) {
            final Map<String, dynamic> resultData         = response.result as Map<String, dynamic>;
            final List<dynamic> lstRows                   = resultData['rows'] as List<dynamic>;
            final List<UnidadPredictiveModel> objResponse = lstRows
                .map<UnidadPredictiveModel>((dynamic i) => UnidadPredictiveModel.fromJson(i as Map<String, dynamic>))
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

  // =========================================================
  // LOCAL OPERATIONS
  // =========================================================
}
