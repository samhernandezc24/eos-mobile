import 'package:eos_mobile/features/auth/data/datasources/local/auth_local_service.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/features/auth/domain/usecases/remote/remote_sign_in_usecase.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/remote/remote_auth_bloc.dart';
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
  /// SERVICES / DATASOURCES
  /// =========================================================
  sl.registerSingleton<Dio>(Dio());

  /// =========================================================
  /// SERVICES / DATASOURCES
  /// =========================================================
  sl.registerSingleton<AuthRemoteApiService>(AuthRemoteApiService(sl()));
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  /// =========================================================
  /// REPOSITORIES
  /// =========================================================
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));

  /// =========================================================
  /// USE CASES
  /// =========================================================
  sl.registerSingleton<RemoteSignInUseCase>(RemoteSignInUseCase(sl()));

  /// =========================================================
  /// STATE MANAGEMENT (BLOC, CUBITS)
  /// =========================================================
  sl.registerFactory<LocalSettingsCubit>(() => LocalSettingsCubit());

  sl.registerFactory<RemoteAuthBloc>(() => RemoteAuthBloc(sl()));

  /// =========================================================
  /// EXTERNAL
  /// =========================================================
  sl.registerLazySingleton<AppLogic>(() => AppLogic());
  sl.registerLazySingleton<SettingsLogic>(() => SettingsLogic());

  sl.registerLazySingleton<Logger>(() => Logger());
}
