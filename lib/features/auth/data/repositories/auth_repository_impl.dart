import 'dart:io';

import 'package:eos_mobile/features/auth/data/datasources/local/auth_local_service.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteApiService, this._authLocalService);

  final AuthRemoteApiService _authRemoteApiService;
  final AuthLocalService _authLocalService;

  // =========================================================
  // REMOTE OPERATIONS
  // =========================================================

  /// INICIO DE SESIÓN (AUTENTICACIÓN)
  @override
  Future<DataState<AccountModel>> signIn(SignInEntity credentials) async {
    try {
      final httpResponse = await _authRemoteApiService.signIn(SignInModel.fromEntity(credentials));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
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

  /// OBTENCIÓN DE CREDENCIALES DEL USUARIO
  @override
  Future<SignInEntity?> getCredentials() async {
    return _authLocalService.getCredentials();
  }

  /// OBTENCIÓN DE INFORMACIÓN DEL USUARIO
  @override
  Future<AccountEntity?> getUserInfo() async {
    return _authLocalService.getUserInfo();
  }

  /// GUARDADO DE CREDENCIALES DEL USUARIO
  @override
  Future<void> storeCredentials(SignInEntity credentials) async {
    return _authLocalService.storeCredentials(credentials);
  }

  /// GUARDADO DE INFORMACIÓN DEL USUARIO
  @override
  Future<void> storeUserInfo(AccountEntity objData) async {
    return _authLocalService.storeUserInfo(objData);
  }

  /// GUARDADO DE SESIÓN DEL USUARIO
  @override
  Future<void> storeUserSession(String token) async {
    return _authLocalService.storeUserSession(token);
  }

  /// CIERRE DE SESIÓN
  @override
  Future<void> logout() async {
    return _authLocalService.logout();
  }
}
