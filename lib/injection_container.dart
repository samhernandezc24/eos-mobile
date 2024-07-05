import 'package:eos_mobile/core/network/api_interceptor.dart';
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
import 'package:eos_mobile/features/auth/presentation/cubit/local/local_auth_cubit.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/categoria/categoria_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/categoria_item/categoria_item_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_tipo/inspeccion_tipo_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/categoria_item_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/categoria_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/inspeccion_tipo_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria/remote_delete_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria/remote_list_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria/remote_store_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria/remote_update_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria_item/remote_delete_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria_item/remote_list_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria_item/remote_store_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria_item/remote_store_duplicate_categoria_item.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria_item/remote_update_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_tipo/remote_delete_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_tipo/remote_list_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_tipo/remote_store_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_tipo/remote_update_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/categoria/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/inspeccion_tipo/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/settings/presentation/cubit/local/local_settings_cubit.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

final GetIt sl = GetIt.instance;

/// Inicializar las dependencias de la aplicación.
///
/// Esta implementación se encarga de registrar todas las dependencias necesarias para el
/// funcionamiento de la aplicación, incluyendo lógicas de arranque, servicios, repositorios,
/// manejadores de estado con BLoC, etc.
Future<void> initializeDependencies() async {
  /// =========================================================
  /// DIO (HTTP, INTERCEPTORS)
  /// =========================================================
  final Dio dio = Dio();
  dio.interceptors.add(ApiInterceptor());
  sl.registerSingleton<Dio>(dio);

  /// =========================================================
  /// SERVICES / DATASOURCES
  /// =========================================================
  sl.registerSingleton<AuthRemoteApiService>(AuthRemoteApiService(sl()));
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  sl.registerSingleton<InspeccionTipoRemoteApiService>(InspeccionTipoRemoteApiService(sl()));
  sl.registerSingleton<CategoriaRemoteApiService>(CategoriaRemoteApiService(sl()));
  sl.registerSingleton<CategoriaItemRemoteApiService>(CategoriaItemRemoteApiService(sl()));

  /// =========================================================
  /// REPOSITORIES
  /// =========================================================
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(),sl()));
  sl.registerSingleton<InspeccionTipoRepository>(InspeccionTipoRepositoryImpl(sl()));
  sl.registerSingleton<CategoriaRepository>(CategoriaRepositoryImpl(sl()));
  sl.registerSingleton<CategoriaItemRepository>(CategoriaItemRepositoryImpl(sl()));

  /// =========================================================
  /// USE CASES
  /// =========================================================
  sl.registerSingleton<RemoteSignInUseCase>(RemoteSignInUseCase(sl()));

  sl.registerSingleton<RemoteListInspeccionTipoUseCase>(RemoteListInspeccionTipoUseCase(sl()));
  sl.registerSingleton<RemoteStoreInspeccionTipoUseCase>(RemoteStoreInspeccionTipoUseCase(sl()));
  sl.registerSingleton<RemoteUpdateInspeccionTipoUseCase>(RemoteUpdateInspeccionTipoUseCase(sl()));
  sl.registerSingleton<RemoteDeleteInspeccionTipoUseCase>(RemoteDeleteInspeccionTipoUseCase(sl()));

  sl.registerSingleton<RemoteListCategoriaUseCase>(RemoteListCategoriaUseCase(sl()));
  sl.registerSingleton<RemoteStoreCategoriaUseCase>(RemoteStoreCategoriaUseCase(sl()));
  sl.registerSingleton<RemoteUpdateCategoriaUseCase>(RemoteUpdateCategoriaUseCase(sl()));
  sl.registerSingleton<RemoteDeleteCategoriaUseCase>(RemoteDeleteCategoriaUseCase(sl()));

  sl.registerSingleton<RemoteListCategoriaItemUseCase>(RemoteListCategoriaItemUseCase(sl()));
  sl.registerSingleton<RemoteStoreCategoriaItemUseCase>(RemoteStoreCategoriaItemUseCase(sl()));
  sl.registerSingleton<RemoteStoreDuplicateCategoriaItemUseCase>(RemoteStoreDuplicateCategoriaItemUseCase(sl()));
  sl.registerSingleton<RemoteUpdateCategoriaItemUseCase>(RemoteUpdateCategoriaItemUseCase(sl()));
  sl.registerSingleton<RemoteDeleteCategoriaItemUseCase>(RemoteDeleteCategoriaItemUseCase(sl()));

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
  sl.registerFactory<RemoteInspeccionTipoBloc>(() => RemoteInspeccionTipoBloc(sl(),sl(),sl(),sl()));
  sl.registerFactory<RemoteCategoriaBloc>(() => RemoteCategoriaBloc(sl(),sl(),sl(),sl()));

  sl.registerFactory<LocalAuthCubit>(() => LocalAuthCubit(sl(),sl(),sl(),sl(),sl(),sl()));
  sl.registerFactory<LocalSettingsCubit>(() => LocalSettingsCubit());

  /// =========================================================
  /// EXTERNAL
  /// =========================================================
  sl.registerLazySingleton<AppLogic>(() => AppLogic());
  sl.registerLazySingleton<SettingsLogic>(() => SettingsLogic());

  sl.registerLazySingleton<Logger>(() => Logger());
}
