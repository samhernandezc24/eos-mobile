import 'package:eos_mobile/features/settings/data/datasources/local/settings_local_data_service.dart';
import 'package:eos_mobile/features/settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._settingsLocalDataService);

  final SettingsLocalDataService _settingsLocalDataService;

  /// OBTENCIÓN DE LA CONFIGURACION DEL TEMA ACTUAL DE LA APLICACION
  @override
  Future<bool> getThemeMode() async {
    return _settingsLocalDataService.getThemeMode();
  }

  /// GUARDADO DE LA CONFIGURACION DEL TEMA ACTUAL DE LA APLICACION
  @override
  Future<void> setThemeMode(bool isDarkModeEnabled) async {
    return _settingsLocalDataService.setThemeMode(isDarkModeEnabled);
  }
}
