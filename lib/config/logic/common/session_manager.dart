import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:eos_mobile/core/utils/auth_utils.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:jwt_decode/jwt_decode.dart';

class SessionManager {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Uuid _uuid = const Uuid();

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

  Future<void> renewFakeToken() async {
    final DateTime tokenExpiryTimestamp = DateTime.now().add(const Duration(hours: 24));
    final String? token = await storage.read(key: 'token');

    if (token != null) {
      // if (!AuthUtils.isTokenExpired(token)) {
      //   $logger.d('El token aún no ha expirado o está próximo a expirar, no es necesario renovarlo.');
      //   return;
      // }

      final Map<String, dynamic> payload = Jwt.parseJwt(token);
      final jwt = JWT(
        {
          'unique_name' : payload['unique_name'],
          'Id' : payload['Id'],
          'Nombre' : payload['Nombre'],
          'Imagen' : payload['Imagen'],
          'IsAdmin' : payload['IsAdmin'],
          'jti' : _uuid.v4(),
          'nbf' : DateTime.now().millisecondsSinceEpoch ~/ 1000,
          'exp' : tokenExpiryTimestamp.toUtc().millisecondsSinceEpoch ~/ 1000,
          'iat' : DateTime.now().millisecondsSinceEpoch ~/ 1000,
        },
      );
      final secretKey = AuthUtils.generateSecureSecretKey();

      print(jwt.sign(SecretKey(secretKey)));
    }
  }
}
