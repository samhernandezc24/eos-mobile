import 'dart:convert';

import 'package:eos_mobile/core/utils/password_utils.dart';
import 'package:eos_mobile/features/auth/data/models/user_model.dart';
import 'package:eos_mobile/shared/shared.dart';

class AuthLocalSource {
  static const String _keyEmail       = 'email';
  static const String _keyPassword    = 'password';
  static const String _keyToken       = 'token';

  static const String _keyUserId      = 'id';
  static const String _keyUser        = 'user';
  static const String _keyPrivilegies = 'privilegies';
  static const String _keyExpiration  = 'expiration';
  static const String _keyFoto        = 'foto';
  static const String _keyNombre      = 'nombre';
  static const String _keyUserKey     = 'key';

  /// Instancia del almacenamiento seguro con `FlutterSecureStorage`.
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  /// Guarda las credenciales del usuario en `SharedPreferences`.
  Future<void> saveCredentials(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String>? existingCredentials = await getCredentials();

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

  /// Guarda la información del usuario autenticado en `SharedPreferences`.
  Future<void> saveUserInfo({
    required String id,
    required UserModel user,
    required DateTime expiration,
    required String nombre,
    required String key,
    String? privilegies,
    String? foto,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, id);
    await prefs.setString(_keyUser, jsonEncode(user.toJson()));
    await prefs.setString(_keyPrivilegies, privilegies ?? '');
    await prefs.setString(_keyExpiration, expiration.toIso8601String());
    await prefs.setString(_keyFoto, foto ?? '');
    await prefs.setString(_keyNombre, nombre);
    await prefs.setString(_keyUserKey, key);
  }

  /// Guarda el token de sesión en el almacenamiento seguro de `FlutterSecureStorage`.
  Future<void> saveUserSession(String token) async {
    await _secureStorage.write(key: _keyToken, value: token);
  }

  /// Carga las credenciales almacenadas del usuario.
  Future<Map<String, String>?> getCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString(_keyEmail);
    if (email != null) return <String, String>{'email': email};
    return null; // No devolver nada.
  }

  /// Carga la información del usuario autenticado de `SharedPreferences`.
  Future<Map<String, String>?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? id          = prefs.getString(_keyUserId);
    final String? user        = prefs.getString(_keyUser);
    final String? privilegies = prefs.getString(_keyPrivilegies);
    final String? expiration  = prefs.getString(_keyExpiration);
    final String? foto        = prefs.getString(_keyFoto);
    final String? nombre      = prefs.getString(_keyNombre);
    final String? key         = prefs.getString(_keyUserKey);

    if (id != null && user != null && privilegies != null && expiration != null
        && foto != null && nombre != null && key != null) {

      return {
        'id'          : id,
        'user'        : user,
        'privilegies' : privilegies,
        'expiration'  : expiration,
        'foto'        : foto,
        'nombre'      : nombre,
        'key'         : key,
      };
    } else {
      return null; // No devolver nada.
    }
  }

  /// Carga el token de sesión del almacenamiento de `FlutterSecureStorage`.
  Future<String?> getUserSession() async {
    return _secureStorage.read(key: _keyToken);
  }

  /// Limpia las credenciales almacenadas del usuario en `SharedPreferences`.
  Future<void> clearSavedCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyPassword);
  }

  /// Limpia la información del usuario en `SharedPreferences`.
  Future<void> clearUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUser);
    await prefs.remove(_keyPrivilegies);
    await prefs.remove(_keyExpiration);
    await prefs.remove(_keyFoto);
    await prefs.remove(_keyNombre);
    await prefs.remove(_keyUserKey);
  }

  /// Limpia el token de sesión del almacenamiento de `FlutterSecureStorage`.
  Future<void> clearUserSession() async {
    await _secureStorage.delete(key: _keyToken);
  }
}
