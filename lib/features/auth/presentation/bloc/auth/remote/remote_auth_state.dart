part of 'remote_auth_bloc.dart';

class RemoteAuthState extends Equatable {
  const RemoteAuthState();

  @override
  List<Object?> get props => [];
}

/// INITIAL STATE
class RemoteAuthInitial extends RemoteAuthState {}

/// LOGIN
class RemoteAuthLoading extends RemoteAuthState {}

class RemoteAuthSuccess extends RemoteAuthState {
  const RemoteAuthSuccess(this.objResponse);

  final AccountEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILURE
class RemoteAuthServerFailure extends RemoteAuthState {
  const RemoteAuthServerFailure(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
