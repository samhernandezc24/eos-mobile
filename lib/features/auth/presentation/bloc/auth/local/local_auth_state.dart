part of 'local_auth_bloc.dart';

class LocalAuthState extends Equatable {
  const LocalAuthState();

  @override
  List<Object?> get props => [];
}

class LocalAuthInitial extends LocalAuthState {}

class LocalCredentialsLoading extends LocalAuthState {}

class LocalCredentialsSuccess extends LocalAuthState {
  const LocalCredentialsSuccess(this.credentials);

  final Map<String, String>? credentials;

  @override
  List<Object?> get props => [ credentials ];
}

class LocalUserInfoSuccess extends LocalAuthState {
  const LocalUserInfoSuccess(this.userInfo);

  final Map<String, String>? userInfo;

  @override
  List<Object?> get props => [ userInfo ];
}

class LocalUserSessionSuccess extends LocalAuthState {
  const LocalUserSessionSuccess(this.session);

  final String? session;

  @override
  List<Object?> get props => [ session ];
}
