import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/user_info_entity.dart';
import 'package:eos_mobile/features/auth/domain/usecases/get_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/get_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/logout_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/store_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/store_user_info_usecase.dart.dart';
import 'package:eos_mobile/features/auth/domain/usecases/store_user_session_usecase.dart.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'local_auth_event.dart';
part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  LocalAuthBloc(
    this._storeCredentialsUseCase,
    this._storeUserInfoUseCase,
    this._storeUserSessionUseCase,
    this._getCredentialsUseCase,
    this._getUserInfoUseCase,
    this._logoutUseCase,
  ) : super(LocalAuthLoading()) {
    on<StoreCredentials>(onStoreCredentials);
    on<StoreUserInfo>(onStoreUserInfo);
    on<StoreUserSession>(onStoreUserSession);
    on<GetCredentials>(onGetCredentials);
    on<GetUserInfo>(onGetUserInfo);
    on<LogoutRequested>(onLogoutRequested);
  }

  // Casos de uso
  final StoreCredentialsUseCase _storeCredentialsUseCase;
  final StoreUserInfoUseCase _storeUserInfoUseCase;
  final StoreUserSessionUseCase _storeUserSessionUseCase;
  final GetCredentialsUseCase _getCredentialsUseCase;
  final GetUserInfoUseCase _getUserInfoUseCase;
  final LogoutUseCase _logoutUseCase;

  Future<void> onStoreCredentials(StoreCredentials event, Emitter<LocalAuthState> emit) async {
    await _storeCredentialsUseCase(params: event.credentials);
    emit(LocalAuthStoreCredentialsSuccess());
  }

  Future<void> onStoreUserInfo(StoreUserInfo event, Emitter<LocalAuthState> emit) async {
    await _storeUserInfoUseCase(params: event.objData);
    emit(LocalAuthStoreUserInfoSuccess());
  }

  Future<void> onStoreUserSession(StoreUserSession event, Emitter<LocalAuthState> emit) async {
    await _storeUserSessionUseCase(params: event.token);
    emit(LocalAuthStoreUserSessionSuccess());
  }

  Future<void> onGetCredentials(GetCredentials event, Emitter<LocalAuthState> emit) async {
    final credentials = await _getCredentialsUseCase(params: NoParams());
    emit(LocalAuthGetCredentialsSuccess(credentials));
  }

  Future<void> onGetUserInfo(GetUserInfo event, Emitter<LocalAuthState> emit) async {
    final objResponse = await _getUserInfoUseCase(params: NoParams());
    emit(LocalAuthGetUserInfoSuccess(objResponse));
  }

  Future<void> onLogoutRequested(LogoutRequested event, Emitter<LocalAuthState> emit) async {
    await _logoutUseCase(params: NoParams());
    emit(LocalAuthLogoutRequested());
  }
}
