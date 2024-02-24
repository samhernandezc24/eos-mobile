import 'dart:io';

import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteApiService, this._secureStorage);

  final AuthRemoteApiService _authRemoteApiService;
  final FlutterSecureStorage _secureStorage;

  /// SIGN IN
  @override
  Future<DataState<AccountModel>> signIn(SignInEntity signIn) async {
    try {
      final String? storedToken = await _secureStorage.read(key: 'access_token');

      if (storedToken != null) {
        // return DataFailed(
        //   DioException(
        //     error: 'El usuario ya ha iniciado sesión anteriormente.',
        //     type: DioExceptionType.
        //   ),
        // );
      }

      final signInModel = SignInModel(email: signIn.email, password: signIn.password);
      final httpResponse = await _authRemoteApiService.signIn(signInModel);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Establecer datos de sesion

        // Guardar el token de acceso en el sistema
        final accessToken = httpResponse.data.token;
        await _secureStorage.write(key: 'access_token', value: accessToken);

        // Retornar la respuesta
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

  /// IS USER AUTHENTICATED
  @override
  Future<DataState<bool>> isAuthenticated() async {
    final String? accessToken = await _secureStorage.read(key: 'access_token');
    if (accessToken != null) {
      return const DataSuccess(true);
    } else {
      return const DataSuccess(false);
    }
  }

  /// SIGN OUT
  @override
  Future<DataState<void>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
