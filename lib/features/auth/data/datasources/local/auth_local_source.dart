import 'package:eos_mobile/core/utils/password_utils.dart';
import 'package:eos_mobile/shared/shared.dart';

class AuthLocalSource {
  static const String _keyEmail     = 'email';
  static const String _keyPassword  = 'password';

  /// Guarda las credenciales del usuario en `SharedPreferences`.
  Future<void> saveCredentials(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String>? existingCredentials = await getSavedCredentials();

    if (existingCredentials != null) {
      if (existingCredentials['email'] != email || !PasswordUtils.verifyPassword(password, existingCredentials['password'] ?? '')) {
        final String hashedPassword = PasswordUtils.createHashedPassword(password);

        await prefs.setString(_keyEmail, email);
        await prefs.setString(_keyPassword, hashedPassword);
      }
    } else {
      // Si no hay credenciales guardadas, guardas las nuevas.
      final String hashedPassword = PasswordUtils.createHashedPassword(password);
      await prefs.setString(_keyEmail, email);
      await prefs.setString(_keyPassword, hashedPassword);
    }
  }

  /// Carga las credenciales almacenadas del usuario.
  Future<Map<String, String>?> getSavedCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email    = prefs.getString(_keyEmail);
    if (email != null) {
      return <String, String>{'email': email};
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
