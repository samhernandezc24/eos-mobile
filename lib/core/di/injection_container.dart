import 'package:eos_mobile/core/helpers/auth_token_helper.dart';
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
import 'package:eos_mobile/features/auth/domain/usecases/remove_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/remove_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/remove_user_session_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/save_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/save_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/save_user_session_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/sign_in_usecase.dart';

// BLOC STATE MANAGEMENT
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_tipo/inspeccion_tipo_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/inspeccion_tipo_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspecciones_tipos/list_inspecciones_tipos_usecase.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
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
  // Helper para operaciones con el token de autenticacion
  sl.registerLazySingleton<AuthTokenHelper>(() => AuthTokenHelper());

  // Servicios / Datasources
  sl.registerSingleton<AuthRemoteApiService>(AuthRemoteApiService(sl()));
  sl.registerSingleton<AuthLocalSource>(AuthLocalSource());

  sl.registerSingleton<InspeccionTipoRemoteApiService>(InspeccionTipoRemoteApiService(sl()));

  // Repositorios
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));
  sl.registerSingleton<InspeccionTipoRepository>(InspeccionTipoRepositoryImpl(sl()));

  // Casos de uso
  sl.registerSingleton<SignInUseCase>(SignInUseCase(sl()));

  sl.registerSingleton<RemoveCredentialsUseCase>(RemoveCredentialsUseCase(sl()));
  sl.registerSingleton<RemoveUserInfoUseCase>(RemoveUserInfoUseCase(sl()));
  sl.registerSingleton<RemoveUserSessionUseCase>(RemoveUserSessionUseCase(sl()));

  sl.registerSingleton<GetCredentialsUseCase>(GetCredentialsUseCase(sl()));
  sl.registerSingleton<GetUserInfoUseCase>(GetUserInfoUseCase(sl()));
  sl.registerSingleton<GetUserSessionUseCase>(GetUserSessionUseCase(sl()));

  sl.registerSingleton<SaveCredentialsUseCase>(SaveCredentialsUseCase(sl()));
  sl.registerSingleton<SaveUserInfoUseCase>(SaveUserInfoUseCase(sl()));
  sl.registerSingleton<SaveUserSessionUseCase>(SaveUserSessionUseCase(sl()));

  sl.registerSingleton<ListInspeccionesTiposUseCase>(ListInspeccionesTiposUseCase(sl()));

  // BLoCs
  sl.registerFactory<RemoteAuthBloc>(() => RemoteAuthBloc(sl()));
  sl.registerFactory<LocalAuthBloc>(() => LocalAuthBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory<RemoteInspeccionTipoBloc>(() => RemoteInspeccionTipoBloc(sl()));
}
