import 'dart:io';

import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/network/errors/exceptions.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion/inspeccion_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_data_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionRepositoryImpl implements InspeccionRepository {
  InspeccionRepositoryImpl(this._inspeccionRemoteApiService);

  final InspeccionRemoteApiService _inspeccionRemoteApiService;

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
}
