import 'dart:io';

import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_tipo/inspeccion_tipo_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class InspeccionTipoRepositoryImpl implements InspeccionTipoRepository {
  InspeccionTipoRepositoryImpl(this._inspeccionTipoRemoteApiService);

  final InspeccionTipoRemoteApiService _inspeccionTipoRemoteApiService;

  // =========================================================
  // REMOTE OPERATIONS
  // =========================================================

  /// LISTADO DE INSPECCIONES TIPOS
  @override
  Future<DataState<List<InspeccionTipoModel>>> list() async {
    try {
      final httpResponse = await _inspeccionTipoRemoteApiService.list();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.session ?? false) {
          if (response.action ?? false) {
            final Map<String, dynamic> resultData       = response.result as Map<String, dynamic>;
            final List<dynamic> lstInspeccionesTipos    = resultData['inspeccionesTipos'] as List<dynamic>;
            final List<InspeccionTipoModel> objResponse = lstInspeccionesTipos
                .map<InspeccionTipoModel>((dynamic i) => InspeccionTipoModel.fromJson(i as Map<String, dynamic>))
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

  /// GUARDADO DE INSPECCION TIPO
  @override
  Future<DataState<IReturn>> store(InspeccionTipoStoreReqEntity objData) {
    // TODO: implement store
    throw UnimplementedError();
  }

  /// ACTUALIZACIÓN DE INSPECCION TIPO
  @override
  Future<DataState<IReturn>> update(InspeccionTipoEntity objData) {
    // TODO: implement update
    throw UnimplementedError();
  }

  /// ELIMINACIÓN DE INSPECCION TIPO
  @override
  Future<DataState<IReturn>> delete(InspeccionTipoIdParamEntity objData) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
