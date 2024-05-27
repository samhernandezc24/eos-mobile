import 'dart:io';

import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_categoria/inspeccion_categoria_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_id_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_categoria/inspeccion_categoria_checklist_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_categoria/inspeccion_categoria_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionCategoriaRepositoryImpl implements InspeccionCategoriaRepository {
  InspeccionCategoriaRepositoryImpl(this._inspeccionCategoriaRemoteApiService);

  final InspeccionCategoriaRemoteApiService _inspeccionCategoriaRemoteApiService;

  /// OBTENCIÓN DE LAS PREGUNTAS DE LA INSPECCION
  @override
  Future<DataState<InspeccionCategoriaChecklistModel>> getPreguntas(InspeccionIdReqEntity objData) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _inspeccionCategoriaRemoteApiService.getPreguntas('application/json', 'Bearer $token', InspeccionIdReqModel.fromEntity(objData));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session ?? false) {
          if (objResponse.action ?? false) {
            final result = objResponse.result as Map<String, dynamic>;
            final InspeccionCategoriaChecklistModel objInspeccionChecklist = InspeccionCategoriaChecklistModel.fromJson(result);

            return DataSuccess(objInspeccionChecklist);
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

  /// GUARDADO DE EVALUACION DE INSPECCION
  @override
  Future<DataState<ServerResponse>> store(InspeccionCategoriaStoreReqEntity objData) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _inspeccionCategoriaRemoteApiService.store('application/json', 'Bearer $token', InspeccionCategoriaStoreReqModel.fromEntity(objData));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session ?? false) {
          if (objResponse.action ?? false) {
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
