import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/network/errors/failures.dart';
import 'package:eos_mobile/features/configuraciones/data/datasources/remote/inspeccion_tipo_api_service.dart';
import 'package:eos_mobile/features/configuraciones/data/models/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_tipo_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionTipoRepositoryImpl implements InspeccionTipoRepository {
  InspeccionTipoRepositoryImpl(this._inspeccionTipoApiService);

  final InspeccionTipoApiService _inspeccionTipoApiService;

  final _secureStorage = const FlutterSecureStorage();

  @override
  Future<Either<Failure, DataState<List<InspeccionTipoModel>>>> fetchInspeccionesTipos() async {
    try {
      final String? retrieveToken = await _secureStorage.read(key: 'access_token');
      final httpResponse  = await _inspeccionTipoApiService.fetchInspeccionesTipos(
        'Bearer $retrieveToken',
        'application/json',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final ApiResponse apiResponse = httpResponse.data;
        final Map<String, dynamic>? resultMap = apiResponse.result as Map<String, dynamic>?;

        final List<dynamic> lstResult =
            resultMap!['inspeccionesTipos'] as List<dynamic>;

        final List<InspeccionTipoModel> objInspeccionesTipos = lstResult
            .map<InspeccionTipoModel>((dynamic json) =>
                InspeccionTipoModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return Right(DataSuccess(objInspeccionesTipos));
      } else {
        return Left(
          ServerFailure(
            dataFailed: DataFailed(
              DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions,
              ),
            ),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(dataFailed: DataFailed(e)));
    }
  }
  //   if (await isconnected) {
  //     // Implementar cuando este listo para servidor.
  //   } else {
  //     try {
  //       // Local
  //       // return Right();
  //     } on LocalException catch (e) {
  //       return const Left(LocalFailure(errorMessage: 'No hay datos almacenados en local.'));
  //     }
  //   }
  // }
}
