class Globals {
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
