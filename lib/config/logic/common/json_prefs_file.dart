import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class JsonPrefsFile {
  JsonPrefsFile(this.name);
  final String name;

  /// Evento que se encarga de cargar los datos almacenados en `SharedPreferences` con la key `name`.
  ///
  /// Retorna el mapa decodificado.
  Future<Map<String, dynamic>> load() async {
    final prefs = (await SharedPreferences.getInstance()).getString(name);
    // print('Cargado: $prefs');
    return Map<String, dynamic>.from(jsonDecode(prefs ?? '{}') as Map<String, dynamic>);
  }

  /// Evento que se encarga de guardar los datos proporcionados en `data` en `SharedPreferences`.
  ///
  /// Almacena la cadena JSON codificada bajo la clave `name` en `SharedPreferences`.
  Future<void> save(Map<String, dynamic> objData) async {
    // print('Guardando $objData');
    await (await SharedPreferences.getInstance()).setString(name, jsonEncode(objData));
  }
}
