import 'dart:math';

class StringUtils {
  static const _digits = '0123456789';

  /// Trunca una cadena a una longitud máxima y agrega puntos suspensivos si es
  /// necesario.
  ///
  /// Si la longitud de [myString] es menor o igual a [maxLength], devuelve [myString]
  /// seguida de puntos suspensivos.
  static String truncateWithEllipsis(int maxLength, String myString) {
    return (myString.length <= maxLength) ? myString : '${myString.substring(0, maxLength)}...';
  }

  /// Capitaliza la primera letra de la cadena y convierte el resto de la
  /// cadena en minúsculas.
  ///
  /// Si [value] es null o vacío, devuelve una cadena vacía.
  static String capitalize(String? value) {
    if (value == null || value.isEmpty) return '';
    return '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}';
  }

  /// Capitaliza cada palabra en la cadena a "proper case", donde la primera
  /// letra de cada palabra está en mayúsculas.
  ///
  /// Si [value] es null, devuelve una cadena vacía.
  static String toProperCase(String? value) {
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

  /// Genera un código númerico random para métodos de creación compartidos.
  static String generateRandomNumericCode({int length = 5}) {
    final Random random   = Random.secure();
    final String code     = String.fromCharCodes(Iterable.generate(length, (_) => _digits.codeUnitAt(random.nextInt(_digits.length))));
    return code;
  }
}
