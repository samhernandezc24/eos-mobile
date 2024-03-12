import 'package:eos_mobile/shared/shared.dart';

class AuthTokenStorage {
  static const String _keyAuthToken           = 'token';
  static const String _keyAuthAccessToken     = 'access_token';
  static const FlutterSecureStorage _storage  = FlutterSecureStorage();

  static Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _keyAuthToken, value: token);
  }

  static Future<void> saveAuthAccessToken(String accessToken) async {
    await _storage.write(key: _keyAuthAccessToken, value: accessToken);
  }

  static Future<String?> getAuthToken() async {
    return _storage.read(key: _keyAuthToken);
  }

  static Future<String?> getAuthAccessToken() async {
    return _storage.read(key: _keyAuthAccessToken);
  }

  static Future<void> destroyAuthToken() async {
    await _storage.deleteAll();
  }
}
