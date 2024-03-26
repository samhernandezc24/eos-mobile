part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthStatus.unknown,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;

  @override
  List<Object?> get props => [ status ];
}
