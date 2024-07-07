import 'dart:io';

import 'package:eos_mobile/core/data/data_source/data_source_persistence.dart';
import 'package:eos_mobile/features/data_source_persistence/data/datasources/remote/data_source_persistence_remote_api_service.dart';
import 'package:eos_mobile/features/data_source_persistence/domain/repositories/data_source_persistence_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class DataSourcePersistenceRepositoryImpl implements DataSourcePersistenceRepository {
  DataSourcePersistenceRepositoryImpl(this._dataSourcePersistenceRemoteApiService);

  final DataSourcePersistenceRemoteApiService _dataSourcePersistenceRemoteApiService;

  // =========================================================
  // REMOTE OPERATIONS
  // =========================================================

  /// ACTUALIZACIÓN DE LOS DATOS PERSISTENTES
  @override
  Future<bool> update(DataSourcePersistence varArgs) async {
    try {
      final httpResponse = await _dataSourcePersistenceRemoteApiService.update(varArgs);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;

        if (response.session ?? false) {
          return response.action ?? false;
        }
      }
      return false;
    } on DioException catch (ex) {
      debugPrint('Error al actualizar DataSourcePersistence: $ex');
      return false;
    }
  }

  // =========================================================
  // LOCAL OPERATIONS
  // =========================================================
}
