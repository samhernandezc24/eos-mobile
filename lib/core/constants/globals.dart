import 'dart:convert';
import 'dart:io';

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

  /// Verifica si la cadena [str] es un link válido.
  ///
  /// Retorna true si la cadena cumple con el formato de URL estándar,
  /// incluyendo protocolo opcional (http o https), dominio y ruta.
  ///
  /// Ejemplos válidos:
  ///   - https://www.example.com
  ///   - http://subdomain.example.com/path?query=param#fragment
  ///
  /// Retorna false si la cadena no cumple con el formato esperado.
  static bool isLink(String str) =>
      str.contains(RegExp(r'^(https?:\/\/)?([\w\d_-]+)\.([\w\d_\.-]+)\/?\??([^#\n\r]*)?#?([^\n\r]*)'));

  /// Convierte un mapa de tipo `Map<String, dyamic>` a una cadena formateada.
  ///
  /// Retorna una cadena que representa el contenido del mapa, donde cada para key-value se
  /// representa en el formato 'key: value, '. Si el mapa es null, retorna una cadena vacía.
  ///
  /// Ejemplo:
  /// ```dart
  /// Map<String, dynamic> jsonMap = {'key1': 'value1', 'key2' : 2};
  /// String formattedString = printMap(jsonMap);
  /// print(formattedString); // Output: 'key1: value1, key2: 2, '
  /// ```
  static String printMap(Map<String, dynamic>? map) {
    String str = '';
    map?.forEach((key, value) => str += '$key: ${value.toString}, ');
    return str;
  }

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

  /// Capitaliza cada palabra en la cadena a "proper case", donde la primera
  /// letra de cada palabra está en mayúsculas.
  ///
  /// Si [value] es null, devuelve una cadena vacía.
  static String properCase(String? value) {
    if (value == null) return '';

    final List<String> words  = value.split(' ');
    String result             = '';

    for (final word in words) {
      final String lower = word.toLowerCase();
      if (lower.isNotEmpty) {
        final proper  = '${lower.substring(0, 1).toUpperCase()}${lower.substring(1)}';
        result        = result.isEmpty ? proper : '$result $proper';
      }
    }
    return result;
  }

  /// Genera un código numérico aleatorio de [length] especificada.
  ///
  /// Este método crea un código numérico aleatorio formado sólo por dígitos.
  /// Utiliza un generador de números aleatorios criptográficamente [Random.secure] para asegurar
  /// que el código generado es impredecible y adecuado para su uso en
  /// contextos sensibles a la seguridad, como la generación de OTP (One-Time Password).
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

  /// Convierte un [file] a una cadena Base64.
  ///
  /// Retorna un Future que contiene la cadena Base64 del [file].
  static Future<String> fileToBase64(File file) async {
    final List<int> fileBytes = await file.readAsBytes();
    final String base64Image = base64Encode(fileBytes);
    return base64Image;
  }

  /// Obtiene el tamaño de un archivo en bytes.
  ///
  /// Retorna el tamaño del archivo si es válido, de lo contrario retorna 0.
  static int getFileSize(File file) {
    if (isValidValue(file) && file.existsSync()) {
      return file.lengthSync();
    }
    return 0;
  }

  /// Obtiene la extensión de un archivo a partir de su [path].
  ///
  /// Retorna la extensión del archivo si es válida, de lo contrario retorna una cadena vacía.
  static String extensionFile(String path) {
    String objReturn = '';
    if (Globals.isValidStringValue(path)) {
      final List<String> parts = path.split('.');
      if (parts.isNotEmpty) {
        objReturn = parts.last;
      }
    }
    return objReturn;
  }

  /// Convierte el tamaño de un archivo en bytes a un formato legible por humanos.
  ///
  /// Este método toma el tamaño del archivo en bytes y lo convierte a un formato más
  /// legible utilizando las unidades adecuadas (por ejemplo, KB, MB, GB).
  /// Recorre la lista de unidades, dividiendo el tamaño entre 1024 hasta que
  /// el tamaño sea inferior a 1024 o alcance la unidad más grande disponible.
  /// El resultado es una cadena con el tamaño redondeado a un decimal si
  /// el tamaño es menor que 10 y la unidad es mayor que bytes.
  static String getReadableFileSizeFromBytes(int sizeInBytes) {
    const List<String> units = ['bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    int l     = 0;
    double n  = sizeInBytes.toDouble();

    while (n >= 1024 && l < units.length - 1) {
      n /= 1024;
      l++;
    }

    return '${n.toStringAsFixed(n < 10 && l > 0 ? 1 : 0)} ${units[l]}';
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
