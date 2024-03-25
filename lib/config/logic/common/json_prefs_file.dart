import 'dart:convert';

import 'package:eos_mobile/shared/shared.dart';

class JsonPrefsFile {
  JsonPrefsFile(this.name);

  final String name;

  /// Carga los datos almacenados con la clave proporcionada desde `SharedPreferences`.
  Future<Map<String, dynamic>> load() async {
    final String? p = (await SharedPreferences.getInstance()).getString(name);
    print('Cargado: $p');
    return Map<String, dynamic>.from(jsonDecode(p ?? '{}') as Map<String, dynamic>);
  }

  /// Guarda los datos proporcionados en forma de mapa con la clave especifica en `SharedPreferences`.
  Future<void> save(Map<String, dynamic> data) async {
    print('Guardando $data');
    await (await SharedPreferences.getInstance()).setString(name, jsonEncode(data));
  }
}
