import 'dart:convert';

import 'package:eos_mobile/shared/shared.dart';

class JsonPrefsFile {
  JsonPrefsFile(this.name);

  final String name;

  Future<Map<String, dynamic>> load() async {
    final SharedPreferences prefs   = await SharedPreferences.getInstance();
    final String? jsonString        = prefs.getString(name);
    print('Cargado: $jsonString');
    return Map<String, dynamic>.from(jsonDecode(jsonString ?? '{}') as Map<String, dynamic>);
  }

  Future<void> save(Map<String, dynamic> data) async {
    print('saving $data');
    await (await SharedPreferences.getInstance()).setString(name, jsonEncode(data));
  }
}
