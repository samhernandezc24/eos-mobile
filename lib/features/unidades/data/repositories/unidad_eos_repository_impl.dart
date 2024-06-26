import 'dart:io';

import 'package:eos_mobile/core/data/predictive.dart';
import 'package:eos_mobile/features/unidades/data/datasources/remote/unidad/unidad_eos_remote_api_service.dart';
import 'package:eos_mobile/features/unidades/data/models/unidad/unidad_eos_predictive_list_model.dart';
import 'package:eos_mobile/features/unidades/domain/repositories/unidad_eos_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadEOSRepositoryImpl implements UnidadEOSRepository {
  UnidadEOSRepositoryImpl(this._unidadEOSRemoteApiService);

  final UnidadEOSRemoteApiService _unidadEOSRemoteApiService;

  /// PREDICTIVO DE UNIDADES DEL EOS
  @override
  Future<DataState<List<UnidadEOSPredictiveListModel>>> predictiveEOS(Predictive varArgs) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _unidadEOSRemoteApiService.predictiveEOS('application/json', 'Bearer $token', varArgs);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;
        if (objResponse.session!) {
          if (objResponse.action!) {
            final result = objResponse.result;
            // ignore: avoid_dynamic_calls
            final List<dynamic> lstRows = result['rows'] as List<dynamic>;
            final List<UnidadEOSPredictiveListModel> objUnidad = lstRows
                .map<UnidadEOSPredictiveListModel>((dynamic i) => UnidadEOSPredictiveListModel.fromJson(i as Map<String, dynamic>))
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
