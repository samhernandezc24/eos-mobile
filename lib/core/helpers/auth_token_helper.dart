import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:eos_mobile/config/logic/common/session_manager.dart';
import 'package:eos_mobile/core/utils/auth_utils.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthTokenHelper {
  AuthTokenHelper({
    FlutterSecureStorage? secureStorage,
  })  : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;
  final Uuid _uuid = const Uuid();

  static const String jwtSecurityToken = 'yPkCqn4kSWLtaJwXvN2jGzpQRyTZ3gdXkt7FeBJP';

  /// Obtiene el token almacenado localmente.
  Future<String?> getLocalToken() async {
    try {
      return await _secureStorage.read(key: 'token');
    } catch (e) {
      $logger.e('Error al obtener el token localmente: $e');
      return null;
    }
  }

  /// Verificar el token para devolver el token actualizado o el token actual.
  Future<String?> retrieveRefreshToken() async {
    final String? token         = await getLocalToken();
    final bool isTokenExpired   = AuthUtils.isTokenExpired(token ?? '');

    if (isTokenExpired) {
      await renewLocalToken();
      return getLocalToken();
    }

    return token;
  }

  /// Guarda el token localmente.
  Future<void> saveLocalToken(String token) async {
    try {
      await _secureStorage.write(key: 'token', value: token);
    } catch (e) {
      $logger.e('Error al guardar el token localmente: $e');
    }
  }

  /// Renueva el token localmente.
  Future<void> renewLocalToken() async {
    final DateTime tokenExpiryTimestamp = DateTime.now().add(const Duration(hours: 24));
    final String? token = await getLocalToken();

    if (token != null) {
      final Map<String, dynamic> payload = Jwt.parseJwt(token);
      final String refreshToken = _generateToken(payload, tokenExpiryTimestamp);

      await saveLocalToken(refreshToken);
    } else {
      $logger.w('No se encontró el token localmente.');
    }
  }

  /// Genera un nuevo token JWT con la información proporcionada.
  String _generateToken(Map<String, dynamic> payload, DateTime expiryTimestamp) {
    final JWT jwt = JWT(
      {
        'unique_name' : payload['unique_name'],
        'Id'          : payload['Id'],
        'Nombre'      : payload['Nombre'],
        'Imagen'      : payload['Imagen'],
        'IsAdmin'     : payload['IsAdmin'],
        'jti'         : _uuid.v4(),
        'nbf'         : DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'exp'         : expiryTimestamp.toUtc().millisecondsSinceEpoch ~/ 1000,
        'iat'         : DateTime.now().millisecondsSinceEpoch ~/ 1000,
      },
    );
    return jwt.sign(SecretKey(jwtSecurityToken));
  }

  /// Test para verificar si el token ha expirado o no.
  Future<void> testExpirationToken() async {
    final SessionManager sessionManager = SessionManager();
    $logger.d('Comprobar la expiración del token ⏳...');
    await sessionManager.checkTokenExpiration();
    $logger.i('Comprobación de la expiración del token completada.');
  }
}
