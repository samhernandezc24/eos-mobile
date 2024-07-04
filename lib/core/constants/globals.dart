import 'package:eos_mobile/shared/shared_libs.dart';

class Globals {
  // CONSTRUCTOR PRIVADO
  Globals._();

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

  /// Verifica si [argObject] es non-nullable.
  ///
  /// Retorna true si [argObject] no es null, de lo contrario retorna false.
  static bool isValidValue(dynamic argObject) => argObject != null;

  /// Verifica si [argObject] es una cadena non-nullable y no vacía después de
  /// eliminar espacios en blanco.
  ///
  /// Retorna true si [argObject] es una cadena non-nullable y no vacía, de lo contrario retorna false.
  static bool isValidStringValue(String argObject) => Globals.isValidValue(argObject) && argObject.trim().isNotEmpty;
}
