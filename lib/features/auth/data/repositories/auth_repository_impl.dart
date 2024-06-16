import 'dart:io';

import 'package:eos_mobile/features/auth/data/datasources/local/auth_local_data_service.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:eos_mobile/features/auth/data/models/user_info_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/user_info_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteApiService, this._authLocalDataService);

  final AuthRemoteApiService _authRemoteApiService;
  final AuthLocalDataService _authLocalDataService;

  /// INICIO DE SESIÓN
  @override
  Future<DataState<AccountModel>> signIn(SignInEntity credentials) async {
    try {
      final httpResponse = await _authRemoteApiService.signIn('application/json', SignInModel.fromEntity(credentials));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final objResponse = httpResponse.data;
        return DataSuccess(objResponse);
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

  /// GUARDADO DE CREDENCIALES DEL USUARIO
  @override
  Future<void> storeCredentials(SignInEntity credentials) async {
    return _authLocalDataService.storeCredentials(SignInModel.fromEntity(credentials));
  }

  /// GUARDADO DE INFORMACIÓN DE LA CUENTA DEL USUARIO
  @override
  Future<void> storeUserInfo(UserInfoEntity objData) async {
    return _authLocalDataService.storeUserInfo(UserInfoModel.fromEntity(objData));
  }

  /// GUARDADO DE LA SESIÓN DEL USUARIO
  @override
  Future<void> storeUserSession(String token) async {
    return _authLocalDataService.storeUserSession(token);
  }

  /// OBTENCIÓN DE CREDENCIALES DEL USUARIO
  @override
  Future<SignInModel?> getCredentials() async {
    return _authLocalDataService.getCredentials();
  }

  /// OBTENCIÓN DE INFORMACIÓN DE LA CUENTA DEL USUARIO
  @override
  Future<UserInfoModel?> getUserInfo() async {
    return _authLocalDataService.getUserInfo();
  }

  /// CIERRE DE SESIÓN DEL USUARIO
  @override
  Future<void> logout() async {
    return _authLocalDataService.logout();
  }
}
