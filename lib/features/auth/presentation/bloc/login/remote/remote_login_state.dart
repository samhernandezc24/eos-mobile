import 'package:dio/dio.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteLoginState extends Equatable {
  const RemoteLoginState({this.account, this.error});

  final AccountEntity? account;
  final DioException? error;

  @override
  List<Object> get props => [account!, error!];
}

class RemoteLoginLoading extends RemoteLoginState {
  const RemoteLoginLoading();
}

class RemoteLoginDone extends RemoteLoginState {
  const RemoteLoginDone(AccountEntity account) : super(account: account);
}

class RemoteLoginFailure extends RemoteLoginState {
  const RemoteLoginFailure(DioException error) : super(error: error);
}
