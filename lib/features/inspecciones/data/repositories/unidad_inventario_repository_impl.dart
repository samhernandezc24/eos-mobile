import 'dart:io';

import 'package:eos_mobile/core/data/predictive_search_req_data.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/network/errors/exceptions.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/unidad_inventario/unidad_inventario_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad_inventario/unidad_inventario_data_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_inventario_repository.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadInventarioRepositoryImpl implements UnidadInventarioRepository {
  UnidadInventarioRepositoryImpl(this._unidadInventarioRemoteApiService);

  final UnidadInventarioRemoteApiService _unidadInventarioRemoteApiService;

  /// BUSCADOR PREDICTIVO DE UNIDAD (INVENTARIO)
  @override
  Future<DataState<UnidadInventarioDataModel>> predictiveUnidadInventario(PredictiveSearchReqEntity predictiveSearch) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _unidadInventarioRemoteApiService.predictiveUnidadInventario(
        'Bearer $token',
        'application/json',
        PredictiveSearchReqModel.fromEntity(predictiveSearch),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ApiResponse apiResponse = httpResponse.data;

        if (httpResponse.data.session) {
          if (httpResponse.data.action) {
            final result = apiResponse.result as Map<String, dynamic>;
            final UnidadInventarioDataModel objUnidadInventario = UnidadInventarioDataModel.fromJson(result);

            return DataSuccess(objUnidadInventario);
          } else {
            return DataFailedMessage(httpResponse.data.message);
          }
        } else {
          return DataFailedMessage(httpResponse.data.message);
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
