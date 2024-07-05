import 'dart:convert';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Globals {
  // CONSTRUCTOR PRIVADO
  Globals._();

  static const _digits = '0123456789';

  /// Padding por defecto para el contenido en un contenedor.
  ///
  /// Ejemplo:
  /// ```dart
  /// InputDecoration(
  ///   contentPadding: Globals.kDefaultContentPadding,
  /// )
  /// ```
  static const EdgeInsets kDefaultContentPadding = EdgeInsets.symmetric(horizontal: 10.2, vertical: 13.2);

  /// Retorna las iniciales de las dos primeras palabras del [value] dado.
  /// Si el [value] no es válido, devuelve una cadena vacía.
  static String getInitials(String value) {
    String objReturn = '';
    if (Globals.isValidStringValue(value)) {
      final List<String> parts = value.split(' ');
      if (parts.isNotEmpty) {
        final StringBuffer strBuffer = StringBuffer();
        for (final part in parts.take(2)) {
          strBuffer.write(part[0].toUpperCase());
        }
        objReturn = strBuffer.toString();
      }
    }
    return objReturn;
  }

  static String generateRandomNumericCode({int length = 5}) {
    final Random random   = Random.secure();
    final String code     = String.fromCharCodes(Iterable.generate(length, (_) => _digits.codeUnitAt(random.nextInt(_digits.length))));
    return code;
  }

  /// Verifica si [argObject] es non-nullable.
  ///
  /// Retorna true si [argObject] no es null, de lo contrario retorna false.
  static bool isValidValue(dynamic argObject) => argObject != null;

  /// Verifica si [argObject] es una cadena non-nullable y no vacía después de
  /// eliminar espacios en blanco.
  ///
  /// Retorna true si [argObject] es una cadena non-nullable y no vacía, de lo contrario retorna false.
  static bool isValidStringValue(String argObject) => Globals.isValidValue(argObject) && argObject.trim().isNotEmpty;

  /// Verifica si un [token] JWT ha expirado.
  ///
  /// Retorna true si [token] ha expirado o si no es válido.
  ///
  /// Opcionalmente se puede proporcionar un [offsetSeconds] para permitir una
  /// holgura al verificar la expiración del token.
  static bool isTokenExpired(String token, [int offsetSeconds = 0]) {
    if (token.isEmpty || token == '') return true; // Retorna true si el token no es válido.

    // Obtener la fecha de expiración del token [exp].
    final DateTime? expirationDate = _getTokenExpirationDate(token);

    // Si no se pudo obtener la fecha de expiración, consideramos el token como expirado.
    if (expirationDate == null) return true;

    // Verificar si el token ha expirado considerando un desface opcional.
    final DateTime currentDate = DateTime.now();
    return !expirationDate.isAfter(currentDate.add(Duration(seconds: offsetSeconds)));
  }

  /// Calcula los minutos restantes hasta que un [token] JWT expire.
  ///
  /// Retorna el número de minutos restantes antes de que el token expire, o null
  /// si no se puede determinar la fecha de expiración.
  static int? minutesUntilTokenExpiration(String token) {
    final DateTime? expirationDate = _getTokenExpirationDate(token);

    if (expirationDate != null) {
      final DateTime currentDate = DateTime.now();
      final Duration remainingTime = expirationDate.difference(currentDate);

      return remainingTime.inMinutes;
    }

    return null;
  }

  /// Genera una clave segura aleatoria.
  ///
  /// La clave generada es una cadena codificada en base64.
  /// Por defecto, genera una clave de longitud '32'.
  static String generateSecureSecretKey({int length = 32}) {
    final Random random           = Random.secure();
    final Uint8List randomBytes   = Uint8List.fromList(List<int>.generate(length, (_) => random.nextInt(256)));
    final String secureKey        = base64Url.encode(randomBytes);

    return secureKey;
  }

  // =========================================================
  // HELPERS INTERNOS
  // =========================================================

  /// Obtiene la fecha de expiración de un [token] JWT.
  ///
  /// Retorna la fecha de expiración del [token] como un objeto `DateTime`.
  /// Retorna null si no se puede determinar la fecha de expiración.
  static DateTime? _getTokenExpirationDate(String token) {
    final Map<String, dynamic>? payload = _decodeToken(token);

    if (payload != null && payload.containsKey('exp')) {
      final int expirationTimestamp = payload['exp'] as int;
      return DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);
    }

    return null; // Retornamos null si payload no tiene un campo 'exp'
  }

  /// Decodifica un [token] JWT y devuelve el payload como un mapa.
  ///
  /// Retorna el payload decodificado del [token] JWT como un mapa de cadenas dinámicas.
  /// Retorna null si el token está vacío o no se puede decodificar.
  static Map<String, dynamic>? _decodeToken(String token) {
    if (token.isEmpty) return null; // Retornamos null si el token está vacío

    try {
      // Decodificar el token usando un decodificador JWT.
      final Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      return decodedToken;
    } catch (e) {
      return null; // Retornamos null si no se puede decodificar el token
    }
  }
}
