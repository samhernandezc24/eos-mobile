import 'dart:io';

import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/auth/data/datasources/local/auth_local_service.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteApiService, this._authLocalService);

  final AuthRemoteApiService _authRemoteApiService;
  final AuthLocalService _authLocalService;

  /// INICIO DE SESIÓN
  @override
  Future<DataState<AccountModel>> signIn(SignInEntity signIn) async {
    try {
      final httpResponse = await _authRemoteApiService.signIn(
        'application/json',
        SignInModel.fromEntity(signIn),
      );

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

  @override
  Future<void> signOut() async {
    return _authLocalService.deleteSession();
  }
}
