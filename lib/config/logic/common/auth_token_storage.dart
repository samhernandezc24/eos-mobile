import 'package:eos_mobile/shared/shared.dart';

class AuthTokenStorage {
  static const String _keyAuthToken           = 'token';
  static const FlutterSecureStorage _storage  = FlutterSecureStorage();

  static Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _keyAuthToken, value: token);
  }

  static Future<String?> getAuthToken() async {
    return _storage.read(key: _keyAuthToken);
  }

  static Future<void> destroyAuthToken() async {
    await _storage.deleteAll();
  }
}
