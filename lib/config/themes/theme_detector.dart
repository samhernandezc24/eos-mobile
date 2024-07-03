import 'package:eos_mobile/config/themes/app_theme.dart';
import 'package:eos_mobile/features/settings/presentation/cubits/local/local_settings_cubit.dart';
import 'package:eos_mobile/shared/shared_libs.dart';

class ThemeDetector {
  const ThemeDetector();

  /// Inicializa el detector de tema de la aplicación.
  static void init(BuildContext context) {
    try {
      _listen(context);     // Evento que escucha el tema inicial de la app
      View.of(context).platformDispatcher.onPlatformBrightnessChanged = () {
        _listen(context);   // Vuelve a escuchar cuando cambie el brillo de la app
      };
    } catch (e) { return; }
  }

  /// Evento que escucha los cambios en el brillo del sistema y actualiza el tema de la app
  /// en consecuencia.
  static void _listen(BuildContext context) {
    final brightness          = View.of(context).platformDispatcher.platformBrightness;
    final bool isDark         = brightness == Brightness.dark;

    // Obtiene el tema correspondiente según el brillo del sistema.
    final ThemeData themeData = isDark ? AppTheme.darkTheme() : AppTheme.lightTheme();

    // Aplica el tema utilizando BlocProvider.
    BlocProvider.of<LocalSettingsCubit>(context).onSetThemeData(themeData, isDark);
  }
}
