import 'dart:io';

import 'package:eos_mobile/features/unidades/data/datasources/remote/unidad/unidad_eos_remote_api_service.dart';
import 'package:eos_mobile/features/unidades/data/models/unidad/unidad_eos_predictive_model.dart';
import 'package:eos_mobile/features/unidades/domain/repositories/unidad_eos_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class UnidadEOSRepositoryImpl implements UnidadEOSRepository {
  UnidadEOSRepositoryImpl(this._unidadEOSRemoteApiService);

  final UnidadEOSRemoteApiService _unidadEOSRemoteApiService;

  // =========================================================
  // REMOTE OPERATIONS
  // =========================================================

  /// PREDICTIVO DE UNIDADES DEL EOS
  @override
  Future<DataState<List<UnidadEOSPredictiveModel>>> predictiveEOS(Predictive varArgs) async {
    try {
      final httpResponse = await _unidadEOSRemoteApiService.predictiveEOS(varArgs);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.session ?? false) {
          if (response.action ?? false) {
            final Map<String, dynamic> resultData             = response.result as Map<String, dynamic>;
            final List<dynamic> lstRows                       = resultData['rows'] as List<dynamic>;
            final List<UnidadEOSPredictiveModel> objResponse  = lstRows
                .map<UnidadEOSPredictiveModel>((dynamic i) => UnidadEOSPredictiveModel.fromJson(i as Map<String, dynamic>))
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
