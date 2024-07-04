import 'dart:convert';

import 'package:eos_mobile/core/data/catalogos/user.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  /// OBTENER CREDENCIALES DEL USUARIO
  Future<SignInEntity?> getCredentials();

  /// OBTENER INFORMACIÓN DEL USUARIO
  Future<AccountEntity?> getUserInfo();

  /// GUARDAR CREDENCIALES DEL USUARIO
  Future<void> storeCredentials(SignInEntity credentials);

  /// GUARDAR INFORMACIÓN DEL USUARIO
  Future<void> storeUserInfo(AccountEntity objData);

  /// GUARDAR LA SESIÓN DEL USUARIO
  Future<void> storeUserSession(String token);

  /// CERRAR SESIÓN
  Future<void> logout();
}

class AuthLocalServiceImpl implements AuthLocalService {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static const String _keyEmail       = 'email';
  static const String _keyPassword    = 'password';
  static const String _keyToken       = 'token';
  static const String _keyId          = 'id';
  static const String _keyUser        = 'user';
  static const String _keyIdRol       = 'idRol';
  static const String _keyRol         = 'rol';
  static const String _keyExpiration  = 'expiration';
  static const String _keyNombre      = 'nombre';
  static const String _keyPrivilegies = 'privilegies';
  static const String _keyFoto        = 'foto';
  static const String _keyKey         = 'key';

  @override
  Future<SignInEntity?> getCredentials() async {
    final String? email     = await _secureStorage.read(key: _keyEmail);
    final String? password  = await _secureStorage.read(key: _keyPassword);

    if (email != null && password != null) {
      return SignInEntity(email: email, password: password);
    }

    return null;
  }

  @override
  Future<AccountEntity?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    final String? id            = prefs.getString(_keyId);
    final String? user          = prefs.getString(_keyUser);
    final String? token         = prefs.getString(_keyToken);
    final String? rol           = prefs.getString(_keyRol);
    final String? idRol         = prefs.getString(_keyIdRol);
    final String? privilegies   = prefs.getString(_keyPrivilegies);
    final String? expiration    = prefs.getString(_keyExpiration);
    final String? foto          = prefs.getString(_keyFoto);
    final String? nombre        = prefs.getString(_keyNombre);
    final String? key           = prefs.getString(_keyKey);

    if (id != null && user != null && token != null && rol != null && idRol != null && privilegies != null && expiration != null &&
        foto != null && nombre != null && key != null) {
      final User objUser = User.fromJson(jsonDecode(user) as Map<String, dynamic>);
      final DateTime parseExpiration = DateTime.parse(expiration);

      return AccountEntity(
        id            : id,
        user          : objUser,
        token         : token,
        rol           : rol,
        idRol         : idRol,
        privilegies   : privilegies,
        expiration    : parseExpiration,
        foto          : foto,
        nombre        : nombre,
        key           : key,
      );
    }

    return null;
  }

  @override
  Future<void> storeCredentials(SignInEntity credentials) async {
    await _secureStorage.write(key: _keyEmail, value: credentials.email);
    await _secureStorage.write(key: _keyPassword, value: credentials.password);
  }

  @override
  Future<void> storeUserInfo(AccountEntity objData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyId, objData.id);
    await prefs.setString(_keyUser, jsonEncode(objData.user.toJson()));
    await prefs.setString(_keyToken, objData.token);
    await prefs.setString(_keyRol, objData.rol ?? '');
    await prefs.setString(_keyIdRol, objData.idRol ?? '');
    await prefs.setString(_keyPrivilegies, objData.privilegies ?? '');
    await prefs.setString(_keyExpiration, objData.expiration.toIso8601String());
    await prefs.setString(_keyFoto, objData.foto ?? '');
    await prefs.setString(_keyNombre, objData.nombre);
    await prefs.setString(_keyKey, objData.key ?? '');
  }

  @override
  Future<void> storeUserSession(String token) async {
    await _secureStorage.write(key: _keyToken, value: token);
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_keyId);
    await prefs.remove(_keyUser);
    await prefs.remove(_keyToken);
    await prefs.remove(_keyRol);
    await prefs.remove(_keyIdRol);
    await prefs.remove(_keyPrivilegies);
    await prefs.remove(_keyExpiration);
    await prefs.remove(_keyFoto);
    await prefs.remove(_keyNombre);
    await prefs.remove(_keyKey);

    await _secureStorage.delete(key: _keyToken);
  }
}
