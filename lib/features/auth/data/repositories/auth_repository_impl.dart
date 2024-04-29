import 'dart:io';

import 'package:eos_mobile/features/auth/data/datasources/local/auth_local_source.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:eos_mobile/features/auth/data/models/user_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

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

  /// GUARDAR CREDENCIALES DEL USUARIO EN LOCAL
  @override
  Future<void> saveCredentials(SignInEntity signIn) async {
    return _authLocalSource.saveCredentials(signIn.email, signIn.password);
  }

  /// GUARDAR LA INFORMACIÓN DEL USUARIO EN LOCAL
  @override
  Future<void> saveUserInfo({
    required String id,
    required UserEntity user,
    required DateTime expiration,
    required String nombre,
    required String key,
    String? privilegies,
    String? foto,
  }) async {
    return _authLocalSource.saveUserInfo(
      id          : id,
      user        : UserModel.fromEntity(user),
      privilegies : privilegies,
      expiration  : expiration,
      foto        : foto,
      nombre      : nombre,
      key         : key,
    );
  }

  /// GUARDAR LA SESIÓN DEL USUARIO EN SECURE LOCAL
  @override
  Future<void> saveUserSession(String token) async {
    return _authLocalSource.saveUserSession(token);
  }

  /// OBTENER LAS CREDENCIALES ALMACENADAS EN LOCAL
  @override
  Future<Map<String, String>?> getCredentials() async {
    return _authLocalSource.getCredentials();
  }

  /// OBTENER LA INFORMACIÓN DEL USUARIO ALMACENADAS EN LOCAL
  @override
  Future<Map<String, String>?> getUserInfo() async {
    return _authLocalSource.getUserInfo();
  }

  ///  OBTENER LA SESIÓN DEL USUARIO ALMACENADA EN SECURE LOCAL
  @override
  Future<String?> getUserSession() async {
    return _authLocalSource.getUserSession();
  }

  /// REMOVER LAS CREDENCIALES ALMACENADAS EN LOCAL
  @override
  Future<void> removeCredentials() async {
    return _authLocalSource.removeCredentials();
  }

  /// REMOVER LA INFORMACIÓN DEL USUARIO ALMACENADA EN LOCAL
  @override
  Future<void> removeUserInfo() async {
    return _authLocalSource.removeUserInfo();
  }

  /// REMOVER LA SESIÓN DEL USUARIO EN SECURE LOCAL
  @override
  Future<void> removeUserSession() async {
    return _authLocalSource.removeUserSession();
  }
}
