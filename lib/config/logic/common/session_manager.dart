import 'package:eos_mobile/shared/shared.dart';
import 'package:jwt_decode/jwt_decode.dart';

class SessionManager {
  Future<void> checkTokenExpiration() async {
    final SharedPreferences prefs         = await SharedPreferences.getInstance();
    const FlutterSecureStorage storage    = FlutterSecureStorage();
    final String? expirationMilliseconds  = prefs.getString('expiration');
    final String value                    = await storage.read(key: 'token') ?? 'Token eliminado o no almacenado';

    if (expirationMilliseconds != null) {
      final DateTime expiration     = DateTime.parse(expirationMilliseconds);
      final DateTime currentTime    = DateTime.now();
      final int diffInSeconds       = expiration.difference(currentTime).inSeconds;

      if (diffInSeconds <= 0) {
        // Token ha expirado
        // await SessionManager.logout();
        $logger..w('El token ha expirado: $expiration')
        ..w('Token expirado: $value');
      } else if (diffInSeconds <= 600) {
        $logger..i('La sesión está a punto de expirar, ingrese la contraseña para renovar o seleccione cancelar.')
        ..d('tiempo restante para la expiracion del token: ${diffInSeconds ~/ 60} minutos.')
        ..d('tiempo restante para la expiracion del token: $diffInSeconds segundos.');
      } else {
        $logger..d('el token todavia tiene tiempo antes de expirar.')
        ..d('tiempo restante para la expiracion del token: ${diffInSeconds ~/ 60} minutos.')
        ..d('Token almacenado: $value')
        ..d(Jwt.parseJwt(value));
      }
    } else {
      $logger.w('No se encontro informacion de expiracion del token en SharedPreferences');
    }
  }
}
