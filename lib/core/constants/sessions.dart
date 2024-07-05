import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:eos_mobile/core/constants/globals.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:uuid/uuid.dart';

/// Clase para gestionar sesiones y tokens en la aplicación EOS Mobile.
class Sessions {
  // CONSTRUCTOR PRIVADO
  Sessions._();

  // CLAVE DE SECURIDAD
  static const String _jwtSecurityToken = 'yPkCqn4kSWLtaJwXvN2jGzpQRyTZ3gdXkt7FeBJP';

  // INSTANCIA DE FLUTTER SECURE STORAGE
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // INSTANCIA DE UUID
  static const Uuid _uuid = Uuid();

  /// Obtiene un valor del almacenamiento local.
  ///
  /// Utiliza [FlutterSecureStorage] para obtener el valor asociado con la [key].
  /// Retorna null si la clave no está presente.
  static Future<String?> getItem(String key) async {
    return _secureStorage.read(key: key);
  }

  /// Establece un valor en el almacenamiento local.
  ///
  /// Utiliza [FlutterSecureStorage] para escribir el [value] asociado con la [key].
  static Future<void> setItem(String key, String? value) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Construye el encabezado HTTP estándar para las solicitudes JSON.
  ///
  /// Obtiene el token de autenticación almacenado localmente y lo incluye en el header.
  static Future<Map<String, String>> header() async {
    final String? token = await _retrieveRefreshToken();

    final Map<String, String> objReturn = {
      'Content-Type'  : 'application/json',
      'Authorization' : 'Bearer $token',
    };

    return objReturn;
  }

  /// Construye el encabezado HTTP para las solicitudes con datos de formulario.
  ///
  /// Obtiene el token de autenticación almacenado localmente y lo incluye en el header.
  static Future<Map<String, String>> headerFormData() async {
    // Obtener el token.
    final String? token = await _retrieveRefreshToken();

    // Construir el objeto de retorno.
    final Map<String, String> objReturn = {
      'Authorization': 'Bearer $token',
    };

    return objReturn;
  }

  // =========================================================
  // HELPERS INTERNOS
  // =========================================================

  /// Obtiene el token de autenticación almacenado localmente y lo retorna.
  ///
  /// Si el token almacenado está expirado, renueva el token localmente antes de
  /// retornarlo.
  static Future<String?> _retrieveRefreshToken() async {
    final String? token         = await Sessions.getItem('token');
    final bool isTokenExpired   = Globals.isTokenExpired(token ?? '');

    // Renueva el token localmente si está expirado.
    if (isTokenExpired) {
      await _renewLocalToken();
      return Sessions.getItem(token ?? '');
    }

    return token;
  }

  /// Renueva el token de autenticación almacenado localmente.
  ///
  /// Genera un nuevo token basado en el token actual y actualiza la fecha de expiración.
  static Future<void> _renewLocalToken() async {
    // Calcular la nueva fecha de expiración para el token.
    final DateTime expirationTimestamp  = DateTime.now().add(const Duration(hours: 24));
    final String? token                 = await Sessions.getItem('token');

    // Genera un nuevo token basado en el token actual.
    if (token != null) {
      final Map<String, dynamic> payload  = Jwt.parseJwt(token);
      final String refreshToken           = _generateToken(payload, expirationTimestamp);

      // Almacenar el nuevo token renovado localmente.
      await Sessions.setItem('token', refreshToken);
    }
  }

  /// Genera un token JWT basado en el payload y la fecha de expiración proporcionados.
  ///
  /// El token generado incluye información específica del usuario como 'unique_name', 'Id',
  /// 'Nombre', 'Imagen', 'IsAdmin', así como un identificador único 'jti' y fechas de inicio
  /// y expiración 'nbf', 'exp' e 'iat'.
  static String _generateToken(Map<String, dynamic> payload, DateTime expirationTimestamp) {
    // Crear un JWT con el payload y firmarlo con la clave de seguridad configurada.
    final JWT jwt = JWT(
      {
        'unique_name' : payload['unique_name'],
        'Id'          : payload['Id'],
        'Nombre'      : payload['Nombre'],
        'Imagen'      : payload['Imagen'],
        'IsAdmin'     : payload['IsAdmin'],
        'jti'         : _uuid.v4(),
        'nbf'         : DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'exp'         : expirationTimestamp.toUtc().millisecondsSinceEpoch ~/ 1000,
        'iat'         : DateTime.now().millisecondsSinceEpoch ~/ 1000,
      },
    );

    return jwt.sign(SecretKey(_jwtSecurityToken));
  }
}
