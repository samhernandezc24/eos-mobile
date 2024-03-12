import 'dart:convert';

import 'package:eos_mobile/features/auth/data/models/user_model.dart';
import 'package:eos_mobile/shared/shared.dart';

class UserInfoStorage {
  static const _keyId           = 'id';
  static const _keyUserModel    = 'user';
  static const _keyPrivilegies  = 'privilegies';
  static const _keyExpiration   = 'expiration';
  static const _keyFoto         = 'foto';
  static const _keyNombre       = 'nombre';
  static const _keyUserKey      = 'userKey';

  static Future<void> saveUserInfo({
    required String id,
    required UserModel user,
    required String? privilegies,
    required DateTime expiration,
    required String? foto,
    required String nombre,
    required String userKey,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyId, id);
    await prefs.setString(_keyUserModel, jsonEncode(user.toJson()));
    await prefs.setString(_keyPrivilegies, privilegies ?? '');
    await prefs.setString(_keyExpiration, expiration.toIso8601String());
    await prefs.setString(_keyFoto, foto ?? '');
    await prefs.setString(_keyNombre, nombre);
    await prefs.setString(_keyUserKey, userKey);
  }

  static Future<Map<String, String?>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'id'            : prefs.getString(_keyId),
      'userModel'     : prefs.getString(_keyUserModel),
      'privilegies'   : prefs.getString(_keyPrivilegies),
      'expiration'    : prefs.getString(_keyExpiration),
      'foto'          : prefs.getString(_keyFoto),
      'nombre'        : prefs.getString(_keyNombre),
      'userKey'       : prefs.getString(_keyUserKey),
    };
  }

  static Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_keyId);
    await prefs.remove(_keyUserModel);
    await prefs.remove(_keyPrivilegies);
    await prefs.remove(_keyExpiration);
    await prefs.remove(_keyFoto);
    await prefs.remove(_keyNombre);
    await prefs.remove(_keyUserKey);
  }
}
