import 'package:eos_mobile/core/data/catalogos/user.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';

abstract class AuthRepository {
  /// API METHODS
  Future<DataState<AccountEntity>> signIn(SignInEntity credentials);

  /// LOCAL METHODS
  Future<void> saveCredentials(SignInEntity signIn);
  Future<void> saveUserInfo({
    required String id,
    required User user,
    required DateTime expiration,
    required String nombre,
    required String key,
    String? privilegies,
    String? foto,
  });
  Future<void> saveUserSession(String token);
  Future<Map<String, String>?> getCredentials();
  Future<Map<String, String>?> getUserInfo();
  Future<String?> getUserSession();
  Future<void> removeCredentials();
  Future<void> removeUserInfo();
  Future<void> removeUserSession();
}
