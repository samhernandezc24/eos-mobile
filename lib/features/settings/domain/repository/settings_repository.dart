abstract class SettingsRepository {
  /// LOCAL METHODS
  Future<bool> getThemeMode();
  Future<void> setThemeMode(bool isDarkModeEnabled);
}
