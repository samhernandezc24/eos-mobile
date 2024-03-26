import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:eos_mobile/shared/shared.dart';

class SecureJsonStorage {
  SecureJsonStorage(this.name);

  final String name;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final _key = encrypt.Key.fromLength(32);

  Future<Map<String, dynamic>> load() async {
    final String? encryptedData = await _secureStorage.read(key: name);
    debugPrint('Cargando informacion encriptada: $encryptedData');
    if (encryptedData != null) {
      final String decryptedData = await _decryptData(encryptedData);
      debugPrint('Cargando informacion desencriptada: $decryptedData');
      return Map<String, dynamic>.from(jsonDecode(decryptedData) as Map<String, dynamic>);
    } else {
      return <String, dynamic>{};
    }
  }

  Future<void> save(Map<String, dynamic> data) async {
    final String encryptedData = await _encryptData(jsonEncode(data));
    debugPrint('Guardando informacion sensible: $data');
    await _secureStorage.write(key: name, value: encryptedData);
  }

  Future<String> _encryptData(String data) async {
    final iv        = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));

    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  Future<String> _decryptData(String encryptedData) async {
    final iv        = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));

    final String decrypted = encrypter.decrypt64(encryptedData, iv: iv);
    return decrypted;
  }
}
