import 'dart:convert';

import 'package:eos_mobile/shared/shared.dart';

class SessionManager {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool start(Map<String, dynamic> jsonSession) {
    if (jsonSession.containsKey('id') &&
        jsonSession.containsKey('user') &&
        jsonSession.containsKey('token') &&
        jsonSession.containsKey('privilegies') &&
        jsonSession.containsKey('expiration') &&
        jsonSession.containsKey('foto') &&
        jsonSession.containsKey('nombre') &&
        jsonSession.containsKey('key')) {

      _setItem('id', jsonSession['id']);
      _setItem('user', jsonSession['user']);
      _setItem('token', jsonSession['token']);
      _setItem('privilegies', jsonSession['privilegies']);
      _setItem('expiration', jsonSession['expiration']);
      _setItem('foto', jsonSession['foto']);
      _setItem('nombre', jsonSession['nombre']);
      _setItem('key', jsonSession['key']);

      return true;
    } else {
      // Eliminar sesion
      return false;
    }
  }

  static dynamic getItem(String key) {
    final value = _prefs?.get(key);
    if (value != null) {
      try {
        return jsonDecode(value as String);
      } catch (e) {
        return value;
      }
    } else {
      return null;
    }
  }

  static void _setItem(String key, dynamic value) {
    final jsonValue = jsonEncode(value);
    _prefs?.setString(key, jsonValue);
  }

  static bool validate() {
    return getItem('id') != null;
  }

  static void remoteItem(String key) {
    _prefs?.remove(key);
  }

  static void sessionDestroy() {
    _prefs?.clear();
  }

  static Map<String, String> header() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${getItem('token')}',
    };
  }

  static Map<String, String> headerFormData() {
    return {
      'Authorization': 'Bearer ${getItem('token')}',
    };
  }

  static Map<String, String> headerFile() {
    return {
      'Authorization': 'Bearer ${getItem('token')}',
    };
  }

  static Map<String, String> headerFileNotToken() {
    return {};
  }
}
