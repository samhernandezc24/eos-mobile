part of 'local_auth_bloc.dart';

sealed class LocalAuthEvent extends Equatable {
  const LocalAuthEvent();

  @override
  List<Object?> get props => [];
}

class LogoutRequested extends LocalAuthEvent {}

class GetCredentials extends LocalAuthEvent {}

class GetUserInfo extends LocalAuthEvent {}

class GetUserSession extends LocalAuthEvent {}

class RemoveCredentials extends LocalAuthEvent {}

class SaveCredentials extends LocalAuthEvent {
  const SaveCredentials(this.signIn);

  final SignInEntity signIn;

  @override
  List<Object?> get props => [ signIn ];
}

class SaveUserInfo extends LocalAuthEvent {
  const SaveUserInfo({
    required this.id,
    required this.user,
    required this.expiration,
    required this.nombre,
    required this.key,
    this.privilegies,
    this.foto,
  });

  final String id;
  final UserEntity user;
  final String? privilegies;
  final DateTime expiration;
  final String? foto;
  final String nombre;
  final String key;

  @override
  List<Object?> get props => [ id, user, privilegies, expiration, foto, nombre, key ];
}

class SaveUserSession extends LocalAuthEvent {
  const SaveUserSession(this.token);

  final String token;

  @override
  List<Object?> get props => [ token ];
}
