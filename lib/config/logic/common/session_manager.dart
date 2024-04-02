import 'package:eos_mobile/core/utils/auth_utils.dart';
import 'package:eos_mobile/shared/shared.dart';

class SessionManager {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> checkTokenExpiration() async {
    final String? token = await storage.read(key: 'token');

    if (token != null) {
      final int? minutesRemaining = AuthUtils.minutesUntilTokenExpiration(token);
      if (AuthUtils.isTokenExpired(token)) {
        // El token ha expirado
        $logger.w('El token ha expirado');
      } else {
        // El token aun no ha expirado
        $logger.d('El token aún no ha expirado');
        $logger.t('Quedan $minutesRemaining minutos antes de que el token expire.');
      }
    } else{
      // El token no esta almacenado
      $logger.w('No se encontro informacion de expiracion del token en almacenamiento local.');
    }
  }
}
