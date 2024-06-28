import 'package:eos_mobile/config/logic/common/json_prefs_file.dart';
import 'package:eos_mobile/config/logic/common/throttler.dart';
import 'package:flutter/foundation.dart';

/// Mixin para proporcionar funcionalidad de carga y guardado con Throttling.
///
/// Throttling: Es una técnica que limita la ejecución de una función a una vez
/// en cada intervalo de tiempo especificado.
mixin ThrottledSaveLoadMixin {
  late final JsonPrefsFile _file  = JsonPrefsFile(fileName);
  final Throttler _throttle       = Throttler(const Duration(seconds: 2));

  /// Evento que se encarga de cargar los datos desde el archivo local.
  ///
  /// Después de cargar los datos, llama al método `copyFromJson()` para
  /// actualizar las variables de estado con los valores cargados.
  Future<void> load() async {
    final Map<String, dynamic> results = await _file.load();
    try {
      copyFromJson(results);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Evento que se encarga de guardar los datos en el archivo
  /// local.
  ///
  /// Utiliza `toJson()` para serializar los datos antes de
  /// guardarlos en el archivo.
  Future<void> save() async {
    if (!kIsWeb) debugPrint('Guardando...');
    try {
      await _file.save(toJson());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Evento que se encarga de programar el guardado de datos
  /// utilizando el `_throttle`. Esto asegura que múltiples
  /// callbacks `scheduleSave()` dentro de un corto periodo
  /// de tiempo solo resulten en ejecución efectiva de `save()`.
  Future<void> scheduleSave() async => _throttle.call(save);

  /// Serialización.
  String get fileName;
  Map<String, dynamic> toJson();
  void copyFromJson(Map<String, dynamic> value);
}
