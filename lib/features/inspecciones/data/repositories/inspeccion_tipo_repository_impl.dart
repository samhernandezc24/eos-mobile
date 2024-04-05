import 'dart:io';

import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_tipo/inspeccion_tipo_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionTipoRepositoryImpl implements InspeccionTipoRepository {
  InspeccionTipoRepositoryImpl(this._inspeccionTipoRemoteApiService);

  final InspeccionTipoRemoteApiService _inspeccionTipoRemoteApiService;

  /// LISTADO DE INSPECCIONES
  @override
  Future<DataState<List<InspeccionTipoModel>>> listInspeccionesTipos() async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _inspeccionTipoRemoteApiService.listInspeccionesTipos('Bearer $token', 'application/json');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ApiResponse apiResponse = httpResponse.data;

        if (httpResponse.data.session) {
          if (httpResponse.data.action) {
            final dynamic result = apiResponse.result;
            final List<dynamic> lstResult = result['inspeccionesTipos'] as List<dynamic>;

            final List<InspeccionTipoModel> lstInspeccionesTipos = lstResult
                .map<InspeccionTipoModel>((dynamic i) => InspeccionTipoModel.fromJson(i as Map<String, dynamic>))
                .toList();

            return DataSuccess(lstInspeccionesTipos);
          } else {
            return DataFailedMessage(apiResponse.title);
          }
        } else {
          return DataFailedMessage(apiResponse.title);
        }
      } else {
        return DataFailed(
          DioException(
            error           : httpResponse.response.statusMessage,
            response        : httpResponse.response,
            type            : DioExceptionType.badResponse,
            requestOptions  : httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }
}
