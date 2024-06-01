import 'dart:async';
import 'dart:io';

import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_fichero/inspeccion_fichero_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_id_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_fichero/inspeccion_fichero_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_fichero/inspeccion_fichero_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_fichero_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionFicheroRepositoryImpl implements InspeccionFicheroRepository {
  InspeccionFicheroRepositoryImpl(this._inspeccionFicheroRemoteApiService) : _progressController = StreamController<double>.broadcast();

  final InspeccionFicheroRemoteApiService _inspeccionFicheroRemoteApiService;
  final StreamController<double> _progressController;

  /// LISTADO DE FICHEROS (FOTOGRAFÍAS) DE UNA INSPECCION
  @override
  Future<DataState<InspeccionFicheroModel>> list(InspeccionIdReqEntity objData) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _inspeccionFicheroRemoteApiService.list('application/json', 'Bearer $token', InspeccionIdReqModel.fromEntity(objData));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session!) {
          if (objResponse.action!) {
            final result = objResponse.result as Map<String, dynamic>;
            final InspeccionFicheroModel objInspeccionFichero = InspeccionFicheroModel.fromJson(result);

            return DataSuccess(objInspeccionFichero);
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

  /// GUARDADO DE FICHERO (FOTOGRAFÍA) DE UNA INSPECCION
  @override
  Future<DataState<ServerResponse>> store(InspeccionFicheroStoreReqEntity objData) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _inspeccionFicheroRemoteApiService.store(
        'application/json',
        'Bearer $token',
        InspeccionFicheroStoreReqModel.fromEntity(objData),
        onSendProgress: (int sent, int total) {
          _progressController.add(sent / total);
        },
      );

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

  @override
  Stream<double> getProgress() => _progressController.stream;

  // Close the StreamController when no longer needed
  void dispose() {
    _progressController.close();
  }
}