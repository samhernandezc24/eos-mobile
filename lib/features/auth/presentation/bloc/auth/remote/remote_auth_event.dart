part of 'remote_auth_bloc.dart';

sealed class RemoteAuthEvent extends Equatable {
  const RemoteAuthEvent();

  @override
  List<Object?> get props => [];
}

/// [SignInUseCase]
class SignIn extends RemoteAuthEvent {
  const SignIn(this.credentials);

  final SignInEntity credentials;

  @override
  List<Object?> get props => [ credentials ];
}
