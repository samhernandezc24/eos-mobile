import 'package:eos_mobile/core/helpers/image_helper.dart';

// DATASOURCES / SERVICES
import 'package:eos_mobile/features/auth/data/datasources/local/auth_local_source.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';

// REPOSITORIES
import 'package:eos_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

// USECASES
import 'package:eos_mobile/features/auth/domain/usecases/get_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/get_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/get_user_session_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/save_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/save_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/save_user_session_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/sign_in_usecase.dart';

// BLOC STATE MANAGEMENT
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

final GetIt sl = GetIt.instance;

/// Inicializar las dependencias de la aplicación.
///
/// Esta implementación se encarga de registrar todas las dependencias necesarias para el
/// funcionamiento de la aplicación, incluyendo lógicas de arranque, servicios, repositorios,
/// manejadores de estado con BLoC, etc.
Future<void> initializeDependencies() async {
  // Cliente de Dio
  sl.registerSingleton<Dio>(Dio());

  // Controlador de la aplicación de nivel superior
  sl.registerLazySingleton<AppLogic>(() => AppLogic());
  // Configuraciones de usuario
  sl.registerLazySingleton<SettingsLogic>(() => SettingsLogic());
  // Helper para operaciones con imágenes
  sl.registerLazySingleton<ImageHelper>(() => ImageHelper());

  // Servicios / Datasources
  sl.registerSingleton<AuthRemoteApiService>(AuthRemoteApiService(sl()));
  sl.registerSingleton<AuthLocalSource>(AuthLocalSource());

  // Repositorios
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));

  // Casos de uso
  sl.registerSingleton<SignInUseCase>(SignInUseCase(sl()));

  sl.registerSingleton<SaveCredentialsUseCase>(SaveCredentialsUseCase(sl()));
  sl.registerSingleton<SaveUserInfoUseCase>(SaveUserInfoUseCase(sl()));
  sl.registerSingleton<SaveUserSessionUseCase>(SaveUserSessionUseCase(sl()));

  sl.registerSingleton<GetCredentialsUseCase>(GetCredentialsUseCase(sl()));
  sl.registerSingleton<GetUserInfoUseCase>(GetUserInfoUseCase(sl()));
  sl.registerSingleton<GetUserSessionUseCase>(GetUserSessionUseCase(sl()));

  // BLoCs
  sl.registerFactory<RemoteAuthBloc>(() => RemoteAuthBloc(sl()));
  sl.registerFactory<LocalAuthBloc>(() => LocalAuthBloc(sl(), sl(), sl(), sl(), sl(), sl()));
}
