import 'package:eos_mobile/config/themes/app_theme.dart';
import 'package:eos_mobile/shared/shared_libs.dart';

part 'local_settings_state.dart';

class LocalSettingsCubit extends Cubit<LocalSettingsState> {
  LocalSettingsCubit() : super(LocalSettingsState(AppTheme.lightTheme(), false));

  Future<void> onSetThemeData(ThemeData themeData, bool isDark) async {
    emit(LocalSettingsState(themeData, isDark));
  }

  Future<void> onSwitchThemeMode() async {
    final ThemeData themeData = state.isDark ? AppTheme.lightTheme() : AppTheme.darkTheme();
    emit(LocalSettingsState(themeData, !state.isDark));
  }
}
