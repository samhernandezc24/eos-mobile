import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

class PasswordUtils {
  /// Genera un salt aleatorio.
  static String _generateSalt() {
    final Random random       = Random.secure();
    final Uint8List saltBytes = Uint8List(16);

    for (int i = 0; i < saltBytes.length; i++) {
      saltBytes[i] = random.nextInt(256);
    }

    return base64Encode(saltBytes);
  }

  /// Genera el hash de la contraseña con el salt.
  static String _hashPassword(String password, String salt) {
    final String saltedPassword   = salt + password;
    final List<int> passwordBytes = utf8.encode(saltedPassword);
    final Digest hash             = sha256.convert(passwordBytes);
    return hash.toString();
  }

  /// Hashear la contraseña.
  static String createHashedPassword(String password) {
    final String salt = _generateSalt();
    final String hash = _hashPassword(password, salt);
    return '$salt|$hash';
  }

  /// Verifica la contraseña hasheada.
  static bool verifyPassword(String password, String storedPassword) {
    final List<String> parts = storedPassword.split('|');
    if (parts.length != 2) return false;

    final String salt = parts[0];
    final String hash = parts[1];

    final String computedHash = _hashPassword(password, salt);

    return computedHash == hash;
  }
}
