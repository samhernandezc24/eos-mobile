class FormValidators {
  /// Validador para campos de correo electrónico.
  ///
  /// Retorna un mensaje de error si [value] es nulo, está vacío o no cumple con el formato de correo electrónico esperado.
  /// Retorna null si [value] es válido.
  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, ingresa tu correo electrónico.';
    }
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, ingresa un correo electrónico válido.';
    }
    return null;
  }

  /// Validador para campos de contraseña.
  ///
  /// Retorna un mensaje de error si [value] es nulo o está vacío.
  /// Retorna null si [value] es válido.
  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, ingresa tu contraseña.';
    }
    return null;
  }

  /// Validador para campos de texto genéricos.
  ///
  /// Retorna un mensaje de error si [value] es nulo o está vacío.
  /// Retorna null si [value] es válido.
  static String? textValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es requerido.';
    }
    return null;
  }
}
