part of 'local_auth_bloc.dart';

sealed class LocalAuthEvent extends Equatable {
  const LocalAuthEvent();

  @override
  List<Object?> get props => [];
}

/// [StoreCredentialsUseCase]
class StoreCredentials extends LocalAuthEvent {
  const StoreCredentials(this.credentials);

  final SignInEntity credentials;

  @override
  List<Object?> get props => [ credentials ];
}

/// [StoreUserInfoUseCase]
class StoreUserInfo extends LocalAuthEvent {
  const StoreUserInfo(this.objData);

  final UserInfoEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [StoreUserSessionUseCase]
class StoreUserSession extends LocalAuthEvent {
  const StoreUserSession(this.token);

  final String token;

  @override
  List<Object?> get props => [ token ];
}

/// [GetCredentialsUseCase]
class GetCredentials extends LocalAuthEvent {}

/// [GetUserInfoUseCase]
class GetUserInfo extends LocalAuthEvent {}

/// [LogoutUseCase]
class LogoutRequested extends LocalAuthEvent {}
