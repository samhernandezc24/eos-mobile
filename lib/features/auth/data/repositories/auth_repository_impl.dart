import 'dart:io';

import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteApiService);

  final AuthRemoteApiService _authRemoteApiService;

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
  @override
  Future<SignInEntity?> getCredentials() {
    // TODO: implement getCredentials
    throw UnimplementedError();
  }

  @override
  Future<AccountEntity?> getUserInfo() {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> storeCredentials(SignInEntity credentials) {
    // TODO: implement storeCredentials
    throw UnimplementedError();
  }

  @override
  Future<void> storeUserInfo(AccountEntity objData) {
    // TODO: implement storeUserInfo
    throw UnimplementedError();
  }

  @override
  Future<void> storeUserSession(String token) {
    // TODO: implement storeUserSession
    throw UnimplementedError();
  }

}
