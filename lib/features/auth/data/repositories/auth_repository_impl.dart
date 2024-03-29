import 'dart:io';

import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/auth/data/datasources/local/auth_local_source.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteApiService, this._authLocalSource);

  final AuthRemoteApiService _authRemoteApiService;
  final AuthLocalSource _authLocalSource;

  /// INICIO DE SESIÓN
  @override
  Future<DataState<AccountModel>> signIn(SignInEntity signIn) async {
    try {
      final httpResponse = await _authRemoteApiService.signIn('application/json', SignInModel.fromEntity(signIn));

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
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }

  /// GUARDAR CREDENCIALES EN LOCAL
  @override
  Future<void> saveCredentials(SignInEntity signIn) async {
    return _authLocalSource.saveCredentials(signIn.email, signIn.password);
  }

  /// OBTENER LAS CREDENCIALES ALMACENADAS EN LOCAL
  @override
  Future<Map<String, String>?> getSavedCredentials() async {
    return _authLocalSource.getSavedCredentials();
  }

  /// LIMPIAR LAS CREDENCIALES ALMACENADAS EN LOCAL
  @override
  Future<void> clearSavedCredentials() async {
    return _authLocalSource.clearSavedCredentials();
  }
}
