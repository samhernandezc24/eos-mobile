class LoginValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Por favor ingresa el correo electrónico.';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Por favor ingresa tu contraseña.';
    }
    return null;
  }
}
