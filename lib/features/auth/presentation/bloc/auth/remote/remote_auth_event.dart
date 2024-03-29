part of 'remote_auth_bloc.dart';

sealed class RemoteAuthEvent extends Equatable {
  const RemoteAuthEvent();

  @override
  List<Object?> get props => [];
}

class LogoutRequested extends RemoteAuthEvent {}

class SignInSubmitted extends RemoteAuthEvent {
  const SignInSubmitted(this.signIn);

  final SignInEntity signIn;

  @override
  List<Object?> get props => [ signIn ];
}
