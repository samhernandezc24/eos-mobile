part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState { }

class SignInLoading extends SignInState { }

class SignInSuccess extends SignInState {
  const SignInSuccess(this.account);

  final AccountEntity? account;

  @override
  List<Object?> get props => [ account ];
}

class SignInFailure extends SignInState {
  const SignInFailure(this.failure);

  final DioException? failure;

  @override
  List<Object?> get props => [ failure ];
}
