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

class LocalCredentialsLoadFailure extends LocalAuthState {
  const LocalCredentialsLoadFailure(this.failure);

  final String? failure;

  @override
  List<Object?> get props => [ failure ];
}
