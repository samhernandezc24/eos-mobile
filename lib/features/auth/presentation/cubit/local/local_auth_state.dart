part of 'local_auth_cubit.dart';

@immutable
abstract class LocalAuthState extends Equatable {
  const LocalAuthState();

  @override
  List<Object?> get props => [];
}

/// INIT STATE
class LocalAuthInit extends LocalAuthState {}

/// GET CREDENTIALS
class LocalAuthGetCredentials extends LocalAuthState {
  const LocalAuthGetCredentials(this.credentials);

  final SignInEntity? credentials;

  @override
  List<Object?> get props => [ credentials ];
}

/// GET USER INFO
class LocalAuthGetUserInfo extends LocalAuthState {
  const LocalAuthGetUserInfo(this.objResponse);

  final AccountEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE CREDENTIALS
class LocalAuthStoreCredentials extends LocalAuthState {}

/// STORE USER INFO
class LocalAuthStoreUserInfo extends LocalAuthState {}

/// STORE USER SESSION
class LocalAuthStoreUserSession extends LocalAuthState {}

/// LOGOUT
class LocalAuthLogout extends LocalAuthState {}
