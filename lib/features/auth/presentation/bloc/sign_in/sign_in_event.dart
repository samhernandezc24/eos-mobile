part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInSubmitted extends SignInEvent {
  const SignInSubmitted(this.signIn);

  final SignInEntity signIn;

  @override
  List<Object> get props => [ signIn ];
}
