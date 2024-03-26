part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticationSignOutRequested extends AuthenticationEvent {}
