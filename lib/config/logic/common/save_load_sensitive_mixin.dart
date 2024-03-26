import 'package:eos_mobile/config/logic/common/secure_json_storage.dart';
import 'package:eos_mobile/config/logic/common/throttler.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Mixin para proporcionar funcionalidad de carga y guardado con throttle.
mixin ThrottledSaveLoadSensitiveMixin {
  late final SecureJsonStorage _secureStorage = SecureJsonStorage(fileName);

  final Throttler _throttle       = Throttler(const Duration(seconds: 2));
  final Logger _logger            = Logger();

  /// Carga de información.
  Future<void> load() async {
    try {
      final Map<String, dynamic> results = await _secureStorage.load();
      copyFromJson(results);
    } on Exception catch (e, stackTrace) {
      _logger.e('Error al cargar datos', error: e, stackTrace: stackTrace);
    }
  }

  /// Guardado de información.
  Future<void> save() async {
    if (!kIsWeb) _logger.d('Guardando información sensible...');
    try {
      await _secureStorage.save(toJson());
    } on Exception catch (e, stackTrace) {
      _logger.e('Error al guardar datos sensibles', error: e, stackTrace: stackTrace);
    }
  }

  /// Programador de guardado con throttle.
  Future<void> scheduleSave() async => _throttle.call(save);

  /// Serialización
  String get fileName;
  Map<String, dynamic> toJson();
  void copyFromJson(Map<String, dynamic> value);
}
