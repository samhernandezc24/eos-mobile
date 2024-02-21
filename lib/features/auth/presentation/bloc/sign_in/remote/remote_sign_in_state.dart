// ignore_for_file: public_member_api_docs, sort_constructors_first
// Estos estados representan los diferentes estados en los que puede estar la autenticacion remota, como
// la carga (loading), exito, error.
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class RemoteSignInState extends Equatable {
  const RemoteSignInState({this.account});

  final AccountEntity? account;

  @override
  List<Object> get props => [account!];
}

abstract class RemoteSignInStatus {
  const RemoteSignInStatus();
}

class RemoteSignInFormSubmitting extends RemoteSignInStatus {}

class RemoteSignInSuccess extends RemoteSignInStatus {}
