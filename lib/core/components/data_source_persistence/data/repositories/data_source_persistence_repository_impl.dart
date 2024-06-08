import 'dart:io';

import 'package:eos_mobile/core/components/data_source_persistence/data/datasources/remote/data_source_persistence_remote_api_service.dart';
import 'package:eos_mobile/core/components/data_source_persistence/domain/repositories/data_source_persistence_repository.dart';
import 'package:eos_mobile/core/data/data_source_persistence.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class DataSourcePersistenceRepositoryImpl implements DataSourcePersistenceRepository {
  DataSourcePersistenceRepositoryImpl(this._dataSourcePersistenceRemoteApiService);

  final DataSourcePersistenceRemoteApiService _dataSourcePersistenceRemoteApiService;

  /// ACTUALIZACIÓN DEL DATA SOURCE PERSISTENCE DEL USUARIO
  @override
  Future<DataState<ServerResponse>> update(DataSourcePersistence varArgs) async {
    try {
      // Obtener el token localmente.
      final String? token = await authTokenHelper.retrieveRefreshToken();

      // Realizar la solicitud usando el token actualizado o el actual.
      final httpResponse = await _dataSourcePersistenceRemoteApiService.update('application/json', 'Bearer $token', varArgs);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ServerResponse objResponse = httpResponse.data;

        if (objResponse.session!) {
          if (objResponse.action!) {
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
