import 'package:eos_mobile/config/logic/common/json_prefs_file.dart';
import 'package:eos_mobile/config/logic/common/throttler.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Mixin para proporcionar funcionalidad de carga y guardado con throttle.
mixin ThrottledSaveLoadMixin {
  late final JsonPrefsFile _file  = JsonPrefsFile(fileName);
  final Throttler _throttle       = Throttler(const Duration(seconds: 2));
  final Logger _logger            = Logger();

  /// Carga de información.
  Future<void> load() async {
    final Map<String, dynamic> results = await _file.load();
    try {
      copyFromJson(results);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Guardado de información.
  Future<void> save() async {
    if (!kIsWeb) _logger.d('Guardando...');
    try {
      await _file.save(toJson());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Programador de guardado con throttle.
  Future<void> scheduleSave() async => _throttle.call(save);

  /// Serialización
  String get fileName;
  Map<String, dynamic> toJson();
  void copyFromJson(Map<String, dynamic> value);
}
