import 'package:eos_mobile/features/settings/presentation/cubits/local/local_settings_cubit.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

final GetIt sl = GetIt.instance;

/// Inicializar las dependencias de la aplicación.
///
/// Esta implementación se encarga de registrar todas las dependencias necesarias para el
/// funcionamiento de la aplicación, incluyendo lógicas de arranque, servicios, repositorios,
/// manejadores de estado con BLoC, etc.
Future<void> initializeDependencies() async {
  /// =========================================================
  /// STATE MANAGEMENT (BLOC, CUBITS)
  /// =========================================================
  sl.registerFactory<LocalSettingsCubit>(() => LocalSettingsCubit());

  /// =========================================================
  /// EXTERNAL
  /// =========================================================
  sl.registerLazySingleton<AppLogic>(() => AppLogic());
  sl.registerLazySingleton<SettingsLogic>(() => SettingsLogic());

  sl.registerLazySingleton<Logger>(() => Logger());
}
