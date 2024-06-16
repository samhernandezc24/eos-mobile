part of 'local_auth_bloc.dart';

class LocalAuthState extends Equatable {
  const LocalAuthState();

  @override
  List<Object?> get props => [];
}

/// INITIAL STATE
class LocalAuthLoading extends LocalAuthState {}

/// STORE CREDENTIALS
class LocalAuthStoreCredentialsSuccess extends LocalAuthState {}

/// STORE USER INFO
class LocalAuthStoreUserInfoSuccess extends LocalAuthState {}

/// STORE USER SESSION
class LocalAuthStoreUserSessionSuccess extends LocalAuthState {}

/// GET CREDENTIALS
class LocalAuthGetCredentialsSuccess extends LocalAuthState {
  const LocalAuthGetCredentialsSuccess(this.credentials);

  final SignInEntity? credentials;

  @override
  List<Object?> get props => [ credentials ];
}

/// GET USER INFO
class LocalAuthGetUserInfoSuccess extends LocalAuthState {
  const LocalAuthGetUserInfoSuccess(this.objResponse);

  final UserInfoEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// LOGOUT
class LocalAuthLogoutRequested extends LocalAuthState {}
