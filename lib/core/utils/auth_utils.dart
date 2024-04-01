import 'dart:convert';

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

    final List<String> parts = token.split('.');

    if (parts.length != 3) { throw Exception('El token inspeccionado no parece ser un JWT. Compruebe que tiene tres partes y consulte https://jwt.io para obtener más información.'); }

    // Decodificar el token usando un decodificador Base64.
    final String decoded = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    return jsonDecode(decoded) as Map<String, dynamic>?;
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
