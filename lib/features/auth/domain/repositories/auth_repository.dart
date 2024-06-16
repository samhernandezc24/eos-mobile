import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/user_info_entity.dart';

abstract class AuthRepository {
  /// API METHODS
  Future<DataState<AccountEntity>> signIn(SignInEntity credentials);

  /// LOCAL METHODS
  Future<void> storeCredentials(SignInEntity credentials);
  Future<void> storeUserInfo(UserInfoEntity objData);
  Future<void> storeUserSession(String token);
  Future<SignInEntity?> getCredentials();
  Future<UserInfoEntity?> getUserInfo();
  Future<void> logout();
}
