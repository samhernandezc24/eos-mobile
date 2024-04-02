import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:jwt_decode/jwt_decode.dart';

class AuthUtils {
  /// Metodo que verifica si el token ya ha expirado.
  static bool isTokenExpired(String token, [int offsetSeconds = 0]) {
    // Devolver true si no hay token.
    if (token.isEmpty || token == '') return true;

    // Obtener la fecha de expiración del token (exp).
    final DateTime? expirationDate = _getTokenExpirationDate(token);

    // Si no se pudo obtener la fecha de expiración, considerar el token como expirado.
    if (expirationDate == null) return true;

    // Verificar si el token ha expirado considerando un desfase opcional.
    final DateTime currentDate = DateTime.now();
    return !expirationDate.isAfter(currentDate.add(Duration(seconds: offsetSeconds)));
  }

  /// Decodifica el token JWT y devuelve el payload.
  static Map<String, dynamic>? _decodeToken(String token) {
    if (token.isEmpty) return null;

    // Decodificar el token usando un decodificador JWT.
    final Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
    return decodedToken;
  }

  /// Obtiene la fecha de expiracion del token.
  static DateTime? _getTokenExpirationDate(String token) {
    final Map<String, dynamic>? payload = _decodeToken(token);

    if (payload != null && payload.containsKey('exp')) {
      final int expirationTimestamp = payload['exp'] as int;
      return DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);
    }
    return null; // Devuelve null si payload no tiene un campo 'exp'
  }

  /// Obtiene el tiempo restante en minutos antes de que el token expire.
  static int? minutesUntilTokenExpiration(String token) {
    final DateTime? expirationDate = _getTokenExpirationDate(token);
    if (expirationDate != null) {
      final DateTime currentDate    = DateTime.now();
      final Duration remainingTime  = expirationDate.difference(currentDate);

      return remainingTime.inMinutes;
    }
    return null; // No devolver nada
  }

  /// Genera una key segura para metodos compartidos.
  static String generateSecureSecretKey({int length = 32}) {
    final Random random = Random.secure();
    final Uint8List randomBytes = Uint8List.fromList(List.generate(length, (_) => random.nextInt(256)));
    final String secureKey = base64Url.encode(randomBytes);
    return secureKey;
  }
}
