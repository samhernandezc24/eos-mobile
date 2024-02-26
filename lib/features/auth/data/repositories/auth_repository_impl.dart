import 'dart:io';

import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteApiService);

  final AuthRemoteApiService _authRemoteApiService;

  // SET THE DEFAULTS
  final _secureStorage = const FlutterSecureStorage();

  /// SIGN IN
  @override
  Future<DataState<AccountModel>> signIn(SignInEntity signIn) async {
    try {
      final signInModel =
          SignInModel(email: signIn.email, password: signIn.password);
      final httpResponse = await _authRemoteApiService.signIn(signInModel);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final accountModel = httpResponse.data;
        final prefs = await SharedPreferences.getInstance();

        // Guardar el token en el almacenamiento seguro
        await _secureStorage.write(
          key: 'access_token',
          value: accountModel.token,
        );
        await _secureStorage.write(key: 'token', value: accountModel.token);
        await _secureStorage.write(key: 'key', value: accountModel.key);

        // Guardar información del usuario
        await prefs.setString('id', accountModel.id);
        await prefs.setString('privilegies', accountModel.privilegies ?? '');
        await prefs.setString('expiration', accountModel.expiration.toString());
        await prefs.setString('foto', accountModel.foto ?? '');
        await prefs.setString('nombre', accountModel.nombre);

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

  /// SIGN OUT
  @override
  Future<DataState<void>> signOut() async {
    try {
      // Recuperar el token almacenado
      final retrieveToken = await _secureStorage.read(key: 'access_token');

      if (retrieveToken == null) {
        return const DataSuccess(null);
      } else {
        final httpResponse = await _authRemoteApiService.signOut(retrieveToken);

        if (httpResponse.response.statusCode == HttpStatus.ok) {
          // Eliminar el access_token del secure storage
          await _secureStorage.deleteAll();

          // Eliminar los demas datos del shared preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();

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
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
