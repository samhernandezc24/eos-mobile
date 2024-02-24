import 'dart:io';

import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/params.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/shared/shared.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteApiService);

  final AuthRemoteApiService _authRemoteApiService;
  
  @override
  Future<DataState<AccountModel>> signIn({required String email, required String password}) async {
    try {
      final httpResponse = await _authRemoteApiService.signIn(
        SignInParams(email: email, password: password),
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
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
