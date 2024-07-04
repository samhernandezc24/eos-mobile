import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/usecases/local/local_get_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/local/local_get_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/local/local_logout_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/local/local_store_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/local/local_store_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/local/local_store_user_session_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

part 'local_auth_state.dart';

class LocalAuthCubit extends Cubit<LocalAuthState> {
  LocalAuthCubit(
    this._localGetCredentialsUseCase,
    this._localGetUserInfoUseCase,
    this._localStoreCredentialsUseCase,
    this._localStoreUserInfoUseCase,
    this._localStoreUserSessionUseCase,
    this._localLogoutUseCase,
  ) : super(LocalAuthInit());

  // USE CASES
  final LocalGetCredentialsUseCase _localGetCredentialsUseCase;
  final LocalGetUserInfoUseCase _localGetUserInfoUseCase;
  final LocalStoreCredentialsUseCase _localStoreCredentialsUseCase;
  final LocalStoreUserInfoUseCase _localStoreUserInfoUseCase;
  final LocalStoreUserSessionUseCase _localStoreUserSessionUseCase;
  final LocalLogoutUseCase _localLogoutUseCase;

  Future<void> onGetCredentials() async {
    final result = await _localGetCredentialsUseCase(params: NoParams());
    emit(LocalAuthGetCredentials(result));
  }

  Future<void> onGetUserInfo() async {
    final result = await _localGetUserInfoUseCase(params: NoParams());
    emit(LocalAuthGetUserInfo(result));
  }

  Future<void> onStoreCredentials(SignInEntity credentials) async {
    await _localStoreCredentialsUseCase(params: credentials);
    emit(LocalAuthStoreCredentials());
  }

  Future<void> onStoreUserInfo(AccountEntity objData) async {
    await _localStoreUserInfoUseCase(params: objData);
    emit(LocalAuthStoreUserInfo());
  }

  Future<void> onStoreUserSession(String token) async {
    await _localStoreUserSessionUseCase(params: token);
    emit(LocalAuthStoreUserSession());
  }

  Future<void> onLogout() async {
    await _localLogoutUseCase(params: NoParams());
    emit(LocalAuthLogout());
  }
}
