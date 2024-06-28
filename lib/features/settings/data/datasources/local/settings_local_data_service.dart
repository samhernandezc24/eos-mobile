import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class SettingsLocalDataService {
  factory SettingsLocalDataService() = _SettingsLocalDataService;

  /// OBTENER LA CONFIGURACION DEL TEMA ACTUAL DE LA APLICACION
  Future<bool> getThemeMode();

  /// GUARDAR LA CONFIGURACION DEL TEMA ACTUAL DE LA APLICACION
  Future<void> setThemeMode(bool isDarkModeEnabled);
}

class _SettingsLocalDataService implements SettingsLocalDataService {
  static const String _themeModeKey = 'theme_mode';

  @override
  Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeModeKey) ?? false;
  }

  @override
  Future<void> setThemeMode(bool isDarkModeEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeModeKey, isDarkModeEnabled);
  }
}
