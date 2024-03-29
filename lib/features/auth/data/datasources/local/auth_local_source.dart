import 'package:eos_mobile/shared/shared.dart';

class AuthLocalSource {
  static const String _keyEmail     = 'email';
  static const String _keyPassword  = 'password';

  /// Guarda las credenciales del usuario en `SharedPreferences`.
  Future<void> saveCredentials(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
  }

  /// Carga las credenciales almacenadas del usuario.
  Future<Map<String, String>?> getSavedCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email     = prefs.getString(_keyEmail);
    final String? password  = prefs.getString(_keyPassword);
    if (email != null && password != null) {
      return <String, String>{'email': email, 'password': password};
    }
    return null;
  }

  /// Limpia las credenciales almacenadas del usuario en `SharedPreferences`.
  Future<void> clearSavedCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyPassword);
  }
}
