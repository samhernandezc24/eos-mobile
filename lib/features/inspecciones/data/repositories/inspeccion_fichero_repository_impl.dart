import 'dart:io';

import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_fichero/inspeccion_fichero_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_fichero/inspeccion_fichero_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_fichero/inspeccion_fichero_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_fichero/inspeccion_fichero_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_fichero_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class InspeccionFicheroRepositoryImpl implements InspeccionFicheroRepository {
  InspeccionFicheroRepositoryImpl(this._inspeccionFicheroRemoteApiService);

  final InspeccionFicheroRemoteApiService _inspeccionFicheroRemoteApiService;

  // =========================================================
  // REMOTE OPERATIONS
  // =========================================================

  // LISTADO DE FICHEROS
  @override
  Future<DataState<InspeccionFicheroModel>> list(InspeccionIdParamEntity objData) async {
    try {
      final httpResponse = await _inspeccionFicheroRemoteApiService.list(InspeccionIdParamModel.fromEntity(objData));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.session ?? false) {
          if (response.action ?? false) {
            final Map<String, dynamic> resultData             = response.result as Map<String, dynamic>;
            final InspeccionFicheroModel objInspeccionFichero = InspeccionFicheroModel.fromJson(resultData);

            return DataSuccess(objInspeccionFichero);
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

  // GUARDADO DE FICHEROS
  @override
  Future<DataState<IReturn>> store(InspeccionFicheroStoreReqEntity objData) async {
    try {
      final httpResponse = await _inspeccionFicheroRemoteApiService.store(InspeccionFicheroStoreReqModel.fromEntity(objData));
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

  // ELIMINACIÓN DE FICHEROS
  @override
  Future<DataState<IReturn>> delete(InspeccionFicheroIdParamEntity objData) async {
    try {
      final httpResponse = await _inspeccionFicheroRemoteApiService.delete(InspeccionFicheroIdParamModel.fromEntity(objData));
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
