import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';

abstract class AuthRepository {
  /// API METHODS

  // API METHODS
  Future<DataState<AccountEntity>> signIn(SignInEntity signIn);
  Future<DataState<void>> signOut();
}
