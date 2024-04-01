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
}
