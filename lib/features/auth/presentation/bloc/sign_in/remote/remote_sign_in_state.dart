import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class RemoteSignInState extends Equatable {
  const RemoteSignInState({this.account, this.failure, });

  final AccountEntity? account;
  final DioException? failure;

  @override
  List<Object?> get props => [account, failure];
}

class RemoteSignInInitial extends RemoteSignInState {
  const RemoteSignInInitial();
}

class RemoteSignInLoading extends RemoteSignInState {
  const RemoteSignInLoading();
}

class RemoteSignInSuccess extends RemoteSignInState {
  const RemoteSignInSuccess(AccountEntity account) : super(account: account);
}

class RemoteSignInFailure extends RemoteSignInState {
  const RemoteSignInFailure(DioException failure) : super(failure: failure);
}
