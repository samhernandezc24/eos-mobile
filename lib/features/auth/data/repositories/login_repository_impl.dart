import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eos_mobile/core/resources/data_state.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/login_api_service.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/login_model.dart';
import 'package:eos_mobile/features/auth/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._loginApiService);

  final LoginApiService _loginApiService;

  @override
  Future<DataState<AccountModel>> loginTreo(LoginModel credentials) async {
    try {
      final response = await _loginApiService.loginTreo(credentials);

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(
          DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioExceptionType.badResponse,
            requestOptions: response.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
