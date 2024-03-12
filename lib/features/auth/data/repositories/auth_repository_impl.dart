import 'dart:io';

import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:retrofit/retrofit.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteApiService);

  final AuthRemoteApiService _authRemoteApiService;

  /// INICIO DE SESIÓN
  @override
  Future<DataState<AccountModel>> signIn(SignInEntity signIn) async {
    try {
      final HttpResponse<AccountModel> objResponse = await _authRemoteApiService.signIn(
        SignInModel(email: signIn.email, password: signIn.password),
      );

      if (objResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(objResponse.data);
      } else {
        return DataFailed(
          DioException(
            error           : objResponse.response.statusMessage,
            response        : objResponse.response,
            type            : DioExceptionType.badResponse,
            requestOptions  : objResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
