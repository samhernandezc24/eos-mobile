abstract class RemoteSignInEvent {}

class SignInEmailChanged extends RemoteSignInEvent {
  SignInEmailChanged({required this.email});

  final String email;
}

class SignInPasswordChanged extends RemoteSignInEvent {
  SignInPasswordChanged({required this.password});

  final String password;
}

class SignInSubmitted extends RemoteSignInEvent {}
