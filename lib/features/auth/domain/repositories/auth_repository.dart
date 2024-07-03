import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

abstract class AuthRepository {
  /// REMOTE OPERATIONS
  Future<DataState<AccountEntity>> signIn(SignInEntity credentials);

  /// LOCAL METHODS
  Future<SignInEntity?> getCredentials();
  Future<AccountEntity?> getUserInfo();

  Future<void> storeCredentials(SignInEntity credentials);
  Future<void> storeUserInfo(AccountEntity objData);
  Future<void> storeUserSession(String token);

  Future<void> logout();
}
