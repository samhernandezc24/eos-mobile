import 'package:eos_mobile/shared/shared_libraries.dart';

class Globals {
  Globals._();

  /// Padding por defecto para el contenido en un contenedor (ej. InputDecoration).
  static const EdgeInsets kDefaultContentPadding = EdgeInsets.symmetric(
    horizontal: 10.2,
    vertical: 13.2,
  );

  /// Verifica si [argObject] es non-nullable.
  ///
  /// Retorna true si [argObject] no es null, de lo contrario retorna false.
  static bool isValidValue(dynamic argObject) => argObject != null;

  /// Verifica si [argObject] es una cadena non-nullable y no vacía después de
  /// eliminar espacios en blanco.
  ///
  /// Retorna true si [argObject] es una cadena non-nullable y no vacía, de lo contrario retorna false.
  static bool isValidStringValue(String argObject) => Globals.isValidValue(argObject) && argObject.trim().isNotEmpty;

  /// Verifica si [argObject] es una lista non-nullable y no vacía.
  ///
  /// Retorna true si [argObject] es una lista non-nullable y no vacía, de lo contrario retorna false.
  static bool isValidArrayValue(List<dynamic> argObject) => Globals.isValidValue(argObject) && argObject.isNotEmpty;

  /// Verifica si [argObject] es un número válido.
  ///
  /// Retorna true si [argObject] no es nulo, es un número y coincide su representación
  /// de cadena con su valor entero después de la conversión, de lo contrario retorna false.
  static bool isValidNumberValue(dynamic argObject) {
    return Globals.isValidValue(argObject) && argObject is num && argObject.toString() == argObject.toInt().toString();
  }
}
