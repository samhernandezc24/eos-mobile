import 'package:eos_mobile/shared/shared_libraries.dart';

class Globals {
  Globals._();

  /// Padding por defecto para el contenido en un contenedor (ej. InputDecoration).
  static const EdgeInsets kDefaultContentPadding = EdgeInsets.symmetric(
    horizontal: 10.2,
    vertical: 13.2,
  );

  static bool isValidValue(dynamic argObject) {
    bool objReturn = false;
    if (argObject != null) {
      objReturn = true;
    }
    return objReturn;
  }

  static bool isValidStringValue(String? argObject) {
    return argObject != null && Globals.isValidValue(argObject.trim());
  }

  static bool isValidArrayValue(List<dynamic>? argObject) {
    return argObject != null && Globals.isValidValue(argObject) && argObject.isNotEmpty;
  }

  static bool isValidNumberValue(dynamic argObject) {
    if (argObject != null || !Globals.isValidValue(argObject)) {
      return false;
    }
    try {
      double.parse(argObject.toString());
      return true;
    } catch (_) {
      return false;
    }
  }
}
