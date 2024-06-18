import 'dart:convert';

import 'package:eos_mobile/core/data/catalogos/user.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:eos_mobile/features/auth/data/models/user_info_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/user_info_entity.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class AuthLocalDataService {
  factory AuthLocalDataService() = _AuthLocalDataService;

  /// GUARDAR CREDENCIALES DEL USUARIO
  Future<void> storeCredentials(SignInModel credentials);

  /// GUARDAR INFORMACIÓN DE LA CUENTA DEL USUARIO
  Future<void> storeUserInfo(UserInfoModel objData);

  /// GUARDAR LA SESIÓN DEL USUARIO
  Future<void> storeUserSession(String token);

  /// OBTENER CREDENCIALES DEL USUARIO
  Future<SignInModel?> getCredentials();

  /// OBTENER INFORMACIÓN DE LA CUENTA DEL USUARIO
  Future<UserInfoModel?> getUserInfo();

  /// CERRAR SESIÓN DEL USUARIO
  Future<void> logout();
}

class _AuthLocalDataService implements AuthLocalDataService {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static const String _keyEmail       = 'email';
  static const String _keyPassword    = 'password';
  static const String _keyToken       = 'token';
  static const String _keyId          = 'id';
  static const String _keyUser        = 'user';
  static const String _keyExpiration  = 'expiration';
  static const String _keyNombre      = 'nombre';
  static const String _keyPrivilegies = 'privilegies';
  static const String _keyFoto        = 'foto';

  @override
  Future<void> storeCredentials(SignInModel credentials) async {
    await _secureStorage.write(key: _keyEmail, value: credentials.email);
    await _secureStorage.write(key: _keyPassword, value: credentials.password);
  }

  @override
  Future<void> storeUserInfo(UserInfoModel objData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyId, objData.id);
    await prefs.setString(_keyUser, jsonEncode(objData.user.toJson()));
    await prefs.setString(_keyExpiration, objData.expiration.toIso8601String());
    await prefs.setString(_keyNombre, objData.nombre);
    await prefs.setString(_keyPrivilegies, objData.privilegies ?? '');
    await prefs.setString(_keyFoto, objData.foto ?? '');
  }

  @override
  Future<void> storeUserSession(String token) async {
    await _secureStorage.write(key: _keyToken, value: token);
  }

  @override
  Future<SignInModel?> getCredentials() async {
    final String? email     = await _secureStorage.read(key: _keyEmail);
    final String? password  = await _secureStorage.read(key: _keyPassword);

    if (email != null && password != null) {
      final objEntity = SignInEntity(email: email, password: password);
      return SignInModel.fromEntity(objEntity);
    }
    return null;
  }

  @override
  Future<UserInfoModel?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    final String? id          = prefs.getString(_keyId);
    final String? user        = prefs.getString(_keyUser);
    final String? expiration  = prefs.getString(_keyExpiration);
    final String? nombre      = prefs.getString(_keyNombre);
    final String? privilegies = prefs.getString(_keyPrivilegies);
    final String? foto        = prefs.getString(_keyFoto);

    if (id != null && user != null && expiration != null && nombre != null && privilegies != null && foto != null) {
      final User objUser = User.fromJson(jsonDecode(user) as Map<String, dynamic>);
      final DateTime parseExpiration = DateTime.parse(expiration);

      final objEntiy = UserInfoEntity(id: id, user: objUser, expiration: parseExpiration, nombre: nombre);

      return UserInfoModel.fromEntity(objEntiy);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyId);
    await prefs.remove(_keyUser);
    await prefs.remove(_keyExpiration);
    await prefs.remove(_keyNombre);
    await prefs.remove(_keyPrivilegies);
    await prefs.remove(_keyFoto);

    await _secureStorage.delete(key: _keyToken);
  }
}
