import 'package:eos_mobile/config/logic/common/auth_token_storage.dart';
import 'package:eos_mobile/shared/shared.dart';

class SessionManager {
  static Future<bool> isAuthenticated() async {
    final authToken = await AuthTokenStorage.getAuthToken();
    return authToken != null;
  }

  static Future<void> handleSession() async {
    final isAuthenticatedUser = await isAuthenticated();
    if (isAuthenticatedUser) {

    }
  }

  Future<void> checkTokenExpiration() async {
    final SharedPreferences prefs         = await SharedPreferences.getInstance();
    final String? expirationMilliseconds  = prefs.getString('expiration');

    if (expirationMilliseconds != null) {
      final DateTime expiration     = DateTime.parse(expirationMilliseconds);
      final DateTime currentTime    = DateTime.now();
      final int diffInSeconds       = expiration.difference(currentTime).inSeconds;

      if (diffInSeconds <= 0) {
        // Token ha expirado
        await SessionManager.logout();
        $logger.w('El token ha expirado');
      } else if (diffInSeconds <= 600) {
        $logger.i('La sesión está a punto de expirar, ingrese la contraseña para renovar o seleccione cancelar.');
      } else {
        $logger..d('el token todavia tiene tiempo antes de expirar.')
        ..d('tiempo restante para la expiracion del token: ${diffInSeconds ~/ 60} minutos.');
      }
    } else {
      $logger.w('No se encontro informacion de expiracion del token en SharedPreferences');
    }
  }

  static Future<void> logout() async {
    await AuthTokenStorage.destroyAuthToken();
  }
}
