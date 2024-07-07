/// Clase para validar elementos de formularios.
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

  /// Validador para campos de número entero.
  ///
  /// Retorna un mensaje de error si [value] es nulo o está vacío.
  /// Retorna null si [value] es válido.
  static String? integerValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    final RegExp numericRegex = RegExp(r'^-?[0-9]+$');
    if (!numericRegex.hasMatch(value)) {
      return 'Por favor, ingresa un número entero válido.';
    }
    return null;
  }

  /// Validador para números decimales que pueden ser nulos.
  ///
  /// Retorna un mensaje de error si [value] es inválido.
  /// Retorna null si [value] es válido.
  static String? decimalValidatorNull(String? value) {
    if (value == null || value.isEmpty) return null;
    final RegExp numericRegex = RegExp(r'^-?[0-9]+(?:\.[0-9]+)?$');
    if (!numericRegex.hasMatch(value)) {
      return 'Por favor, ingresa un número decimal válido.';
    }
    return null;
  }

  /// Validador para números decimales.
  ///
  /// Retorna un mensaje de error si [value] es nulo o está vacío.
  /// Retorna null si [value] es válido.
  static String? decimalValidator(String? value) {
    if (value == null) { return 'Este campo es requerido'; }
    final RegExp numericRegex = RegExp(r'^-?[0-9]+(?:\.[0-9]+)?$');
    if (!numericRegex.hasMatch(value)) {
      return 'Por favor, ingresa un número decimal válido.';
    }
    return null;
  }

  /// Validador para campos de tipo fecha.
  ///
  /// Retorna un mensaje de error si [value] es nulo o está vacío.
  /// Retorna null si [value] es válido.
  static String? dateTimeValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    final RegExp dateRegex = RegExp(r'^(0[1-9]|[12]\d|3[01])[\/\-\.](0[1-9]|1[0-2])[\/\-\.](19|20)\d{2}\s([01]\d|2[0-3]):([0-5]\d)$');
    if (!dateRegex.hasMatch(value)) {
      return 'Por favor, ingresa una fecha en formato dd/mm/yyyy hh:mm.';
    }
    return null;
  }

  /// Validador para campos de tipo hora.
  ///
  /// Retorna un mensaje de error si [value] es nulo o está vacío.
  /// Retorna null si [value] es válido.
  static String? timeValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    final RegExp dateRegex = RegExp(r'^[0-2]\d:[0-5]\d$');
    if (!dateRegex.hasMatch(value)) {
      return 'Por favor, ingresa una hora en formato hh:mm.';
    }
    return null;
  }

  /// Validador para la selección de opción en un dropdown.
  ///
  /// Retorna un mensaje de error si [value] es nulo.
  /// Retorna null si [value] es válido.
  static String? dropdownValidator(Object? value) {
    if (value == null) {
      return 'Por favor, selecciona una opción.';
    }
    return null;
  }
}
