part of 'remote_auth_bloc.dart';

@immutable
abstract class RemoteAuthState extends Equatable {
  const RemoteAuthState();

  @override
  List<Object?> get props => [];
}

/// INIT STATE
class RemoteAuthInit extends RemoteAuthState {}

/// LOADING
class RemoteAuthLoading extends RemoteAuthState {}

/// SUCCESS
class RemoteAuthSuccess extends RemoteAuthState {
  const RemoteAuthSuccess(this.objResponse);

  final AccountEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER ERROR
class RemoteAuthServerError extends RemoteAuthState {
  const RemoteAuthServerError(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}
