import 'dart:io';

import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/data/datasources/remote/inspecciones_remote_api_service.dart';
import 'package:eos_mobile/features/configuraciones/data/models/inspeccion_model.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionRepositoryImpl implements InspeccionRepository {
  InspeccionRepositoryImpl(this._inspeccionesRemoteApiService);

  final InspeccionesRemoteApiService _inspeccionesRemoteApiService;

  final _secureStorage = const FlutterSecureStorage();

  @override
  Future<DataState<List<InspeccionModel>>> getInspecciones() async {
    try {
      // Recuperar el token almacenado
      final retrieveToken = await _secureStorage.read(key: 'access_token');
      final httpResponse =
          await _inspeccionesRemoteApiService.getInspecciones(retrieveToken!);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> createInspeccion(InspeccionEntity inspeccion) async {
    try {
      // Recuperar el token almacenado
      final retrieveToken = await _secureStorage.read(key: 'access_token');
      final httpResponse = await _inspeccionesRemoteApiService.createInspeccion(
        retrieveToken!,
        InspeccionModel.fromEntity(inspeccion),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
