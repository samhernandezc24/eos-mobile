import 'dart:io';

import 'package:eos_mobile/core/data/data_source/data_source.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion/inspeccion_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_create_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_data_source_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_index_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class InspeccionRepositoryImpl implements InspeccionRepository {
  InspeccionRepositoryImpl(this._inspeccionRemoteApiService);

  final InspeccionRemoteApiService _inspeccionRemoteApiService;

  // =========================================================
  // REMOTE OPERATIONS
  // =========================================================

  /// OBTENCIÓN DE DATOS PARA LISTA DE INSPECCIONES
  @override
  Future<DataState<InspeccionIndexModel>> index() async {
    try {
      final httpResponse = await _inspeccionRemoteApiService.index();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.session ?? false) {
          if (response.action ?? false) {
            final Map<String, dynamic> resultData           = response.result as Map<String, dynamic>;
            final InspeccionIndexModel objInspeccionIndex   = InspeccionIndexModel.fromJson(resultData);

            return DataSuccess(objInspeccionIndex);
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

  /// OBTENCIÓN DE DATOS DINAMICOS DE INSPECCIONES
  @override
  Future<DataState<InspeccionDataSourceModel>> dataSource(DataSource varArgs) async {
    try {
      final httpResponse = await _inspeccionRemoteApiService.dataSource(varArgs);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.session ?? false) {
          if (response.action ?? false) {
            final Map<String, dynamic> resultData                   = response.result as Map<String, dynamic>;
            final InspeccionDataSourceModel objInspeccionDataSource = InspeccionDataSourceModel.fromJson(resultData);

            return DataSuccess(objInspeccionDataSource);
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

  /// OBTENCIÓN DE DATOS PARA CREAR INSPECCION
  @override
  Future<DataState<InspeccionCreateModel>> create() async {
    try {
      final httpResponse = await _inspeccionRemoteApiService.create();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.session ?? false) {
          if (response.action ?? false) {
            final Map<String, dynamic> resultData             = response.result as Map<String, dynamic>;
            final InspeccionCreateModel objInspeccionCreate   = InspeccionCreateModel.fromJson(resultData);

            return DataSuccess(objInspeccionCreate);
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

  /// GUARDADO DE INSPECCION
  @override
  Future<DataState<IReturn>> store(InspeccionStoreReqEntity objData) async {
    try {
      final httpResponse = await _inspeccionRemoteApiService.store(InspeccionStoreReqModel.fromEntity(objData));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if (httpResponse.data.session ?? false) {
          if (httpResponse.data.action ?? false) {
            return DataSuccess(httpResponse.data);
          } else {
            return DataFailedMessage(httpResponse.data.message ?? 'Error inesperado');
          }
        } else {
          return DataFailedMessage(httpResponse.data.message ?? 'Error inesperado');
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

  /// CANCELACIÓN DE INSPECCION
  @override
  Future<DataState<IReturn>> cancel(InspeccionIdParamEntity objData) async {
    try {
      final httpResponse = await _inspeccionRemoteApiService.cancel(InspeccionIdParamModel.fromEntity(objData));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if (httpResponse.data.session ?? false) {
          if (httpResponse.data.action ?? false) {
            return DataSuccess(httpResponse.data);
          } else {
            return DataFailedMessage(httpResponse.data.message ?? 'Error inesperado');
          }
        } else {
          return DataFailedMessage(httpResponse.data.message ?? 'Error inesperado');
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
