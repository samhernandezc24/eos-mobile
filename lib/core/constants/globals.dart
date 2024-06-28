import 'dart:convert';
import 'dart:io';

import 'package:eos_mobile/shared/shared_libraries.dart';

class Globals {
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
}
