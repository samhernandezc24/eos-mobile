part of 'remote_sign_in_bloc.dart';

class RemoteSignInState extends Equatable {
  const RemoteSignInState();

  @override
  List<Object?> get props => [];
}

class RemoteSignInInitial extends RemoteSignInState { }

class RemoteSignInLoading extends RemoteSignInState { }

class RemoteSignInSuccess extends RemoteSignInState {
  const RemoteSignInSuccess(this.account);

  final AccountEntity? account;

  @override
  List<Object?> get props => [ account ];
}

class RemoteSignInFailure extends RemoteSignInState {
  const RemoteSignInFailure(this.failure);

  final DioException? failure;

  @override
  List<Object?> get props => [ failure ];
}
