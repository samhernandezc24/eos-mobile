import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:eos_mobile/features/auth/domain/usecases/get_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/get_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/get_user_session_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/remove_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/remove_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/remove_user_session_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/save_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/save_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/save_user_session_usecase.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

part 'local_auth_event.dart';
part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  LocalAuthBloc(
    this._getCredentialsUseCase,
    this._getUserInfoUseCase,
    this._getUserSessionUseCase,
    this._removeCredentialsUseCase,
    this._removeUserInfoUseCase,
    this._removeUserSessionUseCase,
    this._saveCredentialsUseCase,
    this._saveUserInfoUseCase,
    this._saveUserSessionUseCase,
  ) : super(LocalAuthInitial()) {
    on<GetCredentials>(onGetCredentials);
    on<GetUserInfo>(onGetUserInfo);
    on<GetUserSession>(onGetUserSession);
    on<RemoveCredentials>(onRemoveCredentials);
    on<LogoutRequested>(onLogoutRequested);
    on<SaveCredentials>(onSaveCredentials);
    on<SaveUserInfo>(onSaveUserInfo);
    on<SaveUserSession>(onSaveUserSession);
  }

  // Casos de uso
  final GetCredentialsUseCase _getCredentialsUseCase;
  final GetUserInfoUseCase _getUserInfoUseCase;
  final GetUserSessionUseCase _getUserSessionUseCase;

  final RemoveCredentialsUseCase _removeCredentialsUseCase;
  final RemoveUserInfoUseCase _removeUserInfoUseCase;
  final RemoveUserSessionUseCase _removeUserSessionUseCase;

  final SaveCredentialsUseCase _saveCredentialsUseCase;
  final SaveUserInfoUseCase _saveUserInfoUseCase;
  final SaveUserSessionUseCase _saveUserSessionUseCase;

  Future<void> onGetCredentials(GetCredentials event, Emitter<LocalAuthState> emit) async {
    final credentials = await _getCredentialsUseCase(params: NoParams());
    emit(LocalCredentialsSuccess(credentials));
  }

  Future<void> onGetUserInfo(GetUserInfo event, Emitter<LocalAuthState> emit) async {
    final userInfo = await _getUserInfoUseCase(params: NoParams());
    emit(LocalUserInfoSuccess(userInfo));
  }

  Future<void> onGetUserSession(GetUserSession event, Emitter<LocalAuthState> emit) async {
    final userSession = await _getUserSessionUseCase(params: NoParams());
    emit(LocalUserSessionSuccess(userSession));
  }

  Future<void> onRemoveCredentials(RemoveCredentials removeCredentials, Emitter<LocalAuthState> emit) async {
    await _removeCredentialsUseCase(params: NoParams());
  }

  Future<void> onLogoutRequested(LogoutRequested event, Emitter<LocalAuthState> emit) async {
    await _removeUserInfoUseCase(params: NoParams());
    await _removeUserSessionUseCase(params: NoParams());

    emit(LocalLogoutSuccess());
  }

  Future<void> onSaveCredentials(SaveCredentials saveCredentials, Emitter<LocalAuthState> emit) async {
    await _saveCredentialsUseCase(params: saveCredentials.signIn);
    final credentials = await _getCredentialsUseCase(params: NoParams());
    emit(LocalCredentialsSuccess(credentials));
  }

  Future<void> onSaveUserInfo(SaveUserInfo saveUserInfo, Emitter<LocalAuthState> emit) async {
    await _saveUserInfoUseCase(
      params: UserInfoParams(
        id          : saveUserInfo.id,
        user        : saveUserInfo.user,
        privilegies : saveUserInfo.privilegies,
        expiration  : saveUserInfo.expiration,
        foto        : saveUserInfo.foto,
        nombre      : saveUserInfo.nombre,
        key         : saveUserInfo.key,
      ),
    );

    final userInfo = await _getUserInfoUseCase(params: NoParams());
    emit(LocalUserInfoSuccess(userInfo));
  }

  Future<void> onSaveUserSession(SaveUserSession saveUserSession, Emitter<LocalAuthState> emit) async {
    await _saveUserSessionUseCase(params: saveUserSession.token);
    final userSession = await _getUserSessionUseCase(params: NoParams());
    emit(LocalUserSessionSuccess(userSession));
  }
}
