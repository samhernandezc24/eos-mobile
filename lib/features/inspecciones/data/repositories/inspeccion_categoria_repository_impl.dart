import 'dart:io';

import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_categoria/inspeccion_categoria_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_categoria/inspeccion_categoria_checklist_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_categoria/inspeccion_categoria_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class InspeccionCategoriaRepositoryImpl implements InspeccionCategoriaRepository {
  InspeccionCategoriaRepositoryImpl(this._inspeccionCategoriaRemoteApiService);

  final InspeccionCategoriaRemoteApiService _inspeccionCategoriaRemoteApiService;

  // =========================================================
  // REMOTE OPERATIONS
  // =========================================================

  /// OBTENCIÓN DE PREGUNTAS
  @override
  Future<DataState<InspeccionCategoriaChecklistModel>> getPreguntas(InspeccionIdParamEntity objData) async {
    try {
      final httpResponse = await _inspeccionCategoriaRemoteApiService.getPreguntas(InspeccionIdParamModel.fromEntity(objData));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.session ?? false) {
          if (response.action ?? false) {
            final Map<String, dynamic> resultData                 = response.result as Map<String, dynamic>;
            final InspeccionCategoriaChecklistModel objChecklist  = InspeccionCategoriaChecklistModel.fromJson(resultData);

            return DataSuccess(objChecklist);
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

  /// GUARDADO DE EVALUACION
  @override
  Future<DataState<IReturn>> store(InspeccionCategoriaStoreReqEntity objData) async {
    try {
      final httpResponse = await _inspeccionCategoriaRemoteApiService.store(InspeccionCategoriaStoreReqModel.fromEntity(objData));
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
