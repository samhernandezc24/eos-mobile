import 'package:eos_mobile/features/auth/data/datasources/local/auth_local_service.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/features/auth/domain/usecases/local/local_get_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/local/local_get_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/local/local_logout_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/local/local_store_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/local/local_store_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/local/local_store_user_session_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/remote/remote_sign_in_usecase.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/cubits/local/local_auth_cubit.dart';
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

  sl.registerSingleton<LocalGetCredentialsUseCase>(LocalGetCredentialsUseCase(sl()));
  sl.registerSingleton<LocalGetUserInfoUseCase>(LocalGetUserInfoUseCase(sl()));
  sl.registerSingleton<LocalStoreCredentialsUseCase>(LocalStoreCredentialsUseCase(sl()));
  sl.registerSingleton<LocalStoreUserInfoUseCase>(LocalStoreUserInfoUseCase(sl()));
  sl.registerSingleton<LocalStoreUserSessionUseCase>(LocalStoreUserSessionUseCase(sl()));
  sl.registerSingleton<LocalLogoutUseCase>(LocalLogoutUseCase(sl()));

  /// =========================================================
  /// STATE MANAGEMENT (BLOC, CUBITS)
  /// =========================================================
  sl.registerFactory<RemoteAuthBloc>(() => RemoteAuthBloc(sl()));

  sl.registerFactory<LocalAuthCubit>(() => LocalAuthCubit(sl(),sl(),sl(),sl(),sl(),sl()));
  sl.registerFactory<LocalSettingsCubit>(() => LocalSettingsCubit());

  /// =========================================================
  /// EXTERNAL
  /// =========================================================
  sl.registerLazySingleton<AppLogic>(() => AppLogic());
  sl.registerLazySingleton<SettingsLogic>(() => SettingsLogic());

  sl.registerLazySingleton<Logger>(() => Logger());
}
