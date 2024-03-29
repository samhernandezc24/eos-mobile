part of 'local_auth_bloc.dart';

sealed class LocalAuthEvent extends Equatable {
  const LocalAuthEvent();

  @override
  List<Object?> get props => [];
}

class LogoutRequested extends LocalAuthEvent {}

class GetSavedCredentials extends LocalAuthEvent {}

class SaveCredentials extends LocalAuthEvent {
  const SaveCredentials(this.signIn);

  final SignInEntity signIn;

  @override
  List<Object?> get props => [ signIn ];
}
