class FormValidators {
  /// Validación de correo electrónico.
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo electrónico.';
    }

    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor ingresa un correo electrónico válido.';
    }
    return null;
  }

  /// Validación de contraseña.
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu contraseña.';
    }
    return null;
  }

  /// Validación de campos de texto.
  static String? textValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio.';
    }
    return null;
  }

  /// Validación de campos de números enteros.
  static String? integerValidator(String? value) {
    final RegExp numericRegex = RegExp(r'^-?[0-9]+$');
    if (!numericRegex.hasMatch(value ?? '')) {
      return 'Por favor, ingresa un número entero válido.';
    }
    return null;
  }

  static String? dropdownValidator(dynamic value) {
    if (value == null) {
      return 'Por favor, selecciona una opción.';
    }
    return null;
  }
}
