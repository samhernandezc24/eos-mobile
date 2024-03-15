part of 'remote_sign_in_bloc.dart';

sealed class RemoteSignInEvent extends Equatable {
  const RemoteSignInEvent();

  @override
  List<Object> get props => [];
}

class SignInSubmitted extends RemoteSignInEvent {
  const SignInSubmitted(this.signIn);

  final SignInEntity signIn;

  @override
  List<Object> get props => [ signIn ];
}
