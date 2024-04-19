part of 'remote_auth_bloc.dart';

class RemoteAuthState extends Equatable {
  const RemoteAuthState();

  @override
  List<Object?> get props => [];
}

class RemoteAuthInitial extends RemoteAuthState {}

class RemoteSignInLoading extends RemoteAuthState {}

class RemoteSignInSuccess extends RemoteAuthState {
  const RemoteSignInSuccess(this.account);

  final AccountEntity? account;

  @override
  List<Object?> get props => [ account ];
}

class RemoteSignInFailure extends RemoteAuthState {
  const RemoteSignInFailure(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
