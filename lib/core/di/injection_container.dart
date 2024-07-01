import 'package:eos_mobile/core/helpers/auth_token_helper.dart';
import 'package:eos_mobile/core/helpers/image_helper.dart';
import 'package:eos_mobile/features/auth/data/datasources/local/auth_local_data_service.dart';

import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/features/auth/domain/usecases/get_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/get_user_info_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/logout_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/store_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/store_user_info_usecase.dart.dart';
import 'package:eos_mobile/features/auth/domain/usecases/store_user_session_usecase.dart.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/local/db/inspeccion_db.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/local/inspeccion/inspeccion_local_data_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/categoria/categoria_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/categoria_item/categoria_item_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/data_source_persistence/data_source_persistence_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion/inspeccion_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_categoria/inspeccion_categoria_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_fichero/inspeccion_fichero_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_tipo/inspeccion_tipo_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/unidad/unidad_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/categoria_item_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/categoria_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/data_source_persistence_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/inspeccion_categoria_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/inspeccion_fichero_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/inspeccion_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/inspeccion_tipo_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/unidad_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/data_source_persistence_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_categoria_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_fichero_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/delete_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/list_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/store_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/update_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/delete_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/list_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/store_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/store_duplicate_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/update_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/data_source_persistence/update_data_source_persistence_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/cancel_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/create_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/data_source_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/finish_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/index_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/store_inspeccion_signature_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/store_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_categoria/get_preguntas_inspeccion_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_categoria/store_inspeccion_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_fichero/delete_inspeccion_fichero_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_fichero/list_inspeccion_fichero_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_fichero/store_inspeccion_fichero_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/delete_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/list_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/store_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/update_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/create_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/data_source_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/index_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/predictive_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/store_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/data_source_persistence/remote_data_source_persistence_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_categoria/remote/remote_inspeccion_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_fichero/remote/remote_inspeccion_fichero_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';
import 'package:eos_mobile/features/settings/data/datasources/local/settings_local_data_service.dart';
import 'package:eos_mobile/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:eos_mobile/features/settings/domain/repository/settings_repository.dart';
import 'package:eos_mobile/features/settings/domain/usecases/get_theme_mode_usecase.dart';
import 'package:eos_mobile/features/settings/domain/usecases/set_theme_mode_usecase.dart';
import 'package:eos_mobile/features/settings/presentation/bloc/local/local_settings_bloc.dart';
import 'package:eos_mobile/features/unidades/data/datasources/remote/unidad/unidad_eos_remote_api_service.dart';
import 'package:eos_mobile/features/unidades/data/repositories/unidad_eos_repository_impl.dart';
import 'package:eos_mobile/features/unidades/domain/repositories/unidad_eos_repository.dart';
import 'package:eos_mobile/features/unidades/domain/usecases/unidad/predictive_eos_unidad_usecase.dart';
import 'package:eos_mobile/features/unidades/presentation/bloc/unidad/remote/remote_unidad_eos_bloc.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

final GetIt sl = GetIt.instance;

/// Inicializar las dependencias de la aplicación.
///
/// Esta implementación se encarga de registrar todas las dependencias necesarias para el
/// funcionamiento de la aplicación, incluyendo lógicas de arranque, servicios, repositorios,
/// manejadores de estado con BLoC, etc.
Future<void> initializeDependencies() async {
  /// ==================== LOCAL DATABASE (OBJECTBOX) ==================== ///
  sl.registerLazySingleton<InspeccionDB>(() => InspeccionDB());

  /// ==================== DIO (REST CLIENT) ==================== ///
  sl.registerSingleton<Dio>(Dio());

  /// ==================== LOGIC, GLOBALS & HELPERS ==================== ///
  sl.registerLazySingleton<AppLogic>(() => AppLogic());
  sl.registerLazySingleton<AuthTokenHelper>(() => AuthTokenHelper());
  sl.registerLazySingleton<ImageHelper>(() => ImageHelper());
  sl.registerLazySingleton<SettingsLogic>(() => SettingsLogic());

  /// ==================== SERVICIOS / DATASOURCES ==================== ///
  // A
  sl.registerSingleton<AuthLocalDataService>(AuthLocalDataService());
  sl.registerSingleton<AuthRemoteApiService>(AuthRemoteApiService(sl()));

  // C
  sl.registerSingleton<CategoriaRemoteApiService>(CategoriaRemoteApiService(sl()));
  sl.registerSingleton<CategoriaItemRemoteApiService>(CategoriaItemRemoteApiService(sl()));

  // D
  sl.registerSingleton<DataSourcePersistenceRemoteApiService>(DataSourcePersistenceRemoteApiService(sl()));

  // I
  sl.registerSingleton<InspeccionLocalDataService>(InspeccionLocalDataService(sl()));
  sl.registerSingleton<InspeccionRemoteApiService>(InspeccionRemoteApiService(sl()));
  sl.registerSingleton<InspeccionCategoriaRemoteApiService>(InspeccionCategoriaRemoteApiService(sl()));
  sl.registerSingleton<InspeccionFicheroRemoteApiService>(InspeccionFicheroRemoteApiService(sl()));
  sl.registerSingleton<InspeccionTipoRemoteApiService>(InspeccionTipoRemoteApiService(sl()));

  /// S
  sl.registerSingleton<SettingsLocalDataService>(SettingsLocalDataService());

  // U
  sl.registerSingleton<UnidadRemoteApiService>(UnidadRemoteApiService(sl()));
  sl.registerSingleton<UnidadEOSRemoteApiService>(UnidadEOSRemoteApiService(sl()));

  /// ==================== REPOSITORIOS ==================== ///
  /// A
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));

  /// D
  sl.registerSingleton<DataSourcePersistenceRepository>(DataSourcePersistenceRepositoryImpl(sl()));

  /// C
  sl.registerSingleton<CategoriaRepository>(CategoriaRepositoryImpl(sl()));
  sl.registerSingleton<CategoriaItemRepository>(CategoriaItemRepositoryImpl(sl()));

  /// I
  sl.registerSingleton<InspeccionRepository>(InspeccionRepositoryImpl(sl(), sl()));
  sl.registerSingleton<InspeccionCategoriaRepository>(InspeccionCategoriaRepositoryImpl(sl()));
  sl.registerSingleton<InspeccionFicheroRepository>(InspeccionFicheroRepositoryImpl(sl()));
  sl.registerSingleton<InspeccionTipoRepository>(InspeccionTipoRepositoryImpl(sl()));

  /// S
  sl.registerSingleton<SettingsRepository>(SettingsRepositoryImpl(sl()));

  /// U
  sl.registerSingleton<UnidadRepository>(UnidadRepositoryImpl(sl()));
  sl.registerSingleton<UnidadEOSRepository>(UnidadEOSRepositoryImpl(sl()));

  /// ==================== CASOS DE USO ==================== ///
  // C
  sl.registerSingleton<CancelInspeccionUseCase>(CancelInspeccionUseCase(sl()));
  sl.registerSingleton<CreateInspeccionUseCase>(CreateInspeccionUseCase(sl()));
  sl.registerSingleton<CreateUnidadUseCase>(CreateUnidadUseCase(sl()));

  // D
  sl.registerSingleton<DataSourceInspeccionUseCase>(DataSourceInspeccionUseCase(sl()));
  sl.registerSingleton<DataSourceUnidadUseCase>(DataSourceUnidadUseCase(sl()));
  sl.registerSingleton<DeleteCategoriaUseCase>(DeleteCategoriaUseCase(sl()));
  sl.registerSingleton<DeleteCategoriaItemUseCase>(DeleteCategoriaItemUseCase(sl()));
  sl.registerSingleton<DeleteInspeccionTipoUseCase>(DeleteInspeccionTipoUseCase(sl()));
  sl.registerSingleton<DeleteInspeccionFicheroUseCase>(DeleteInspeccionFicheroUseCase(sl()));

  // F
  sl.registerSingleton<FinishInspeccionUseCase>(FinishInspeccionUseCase(sl()));

  // G
  sl.registerSingleton<GetCredentialsUseCase>(GetCredentialsUseCase(sl()));
  sl.registerSingleton<GetPreguntasInspeccionCategoriaUseCase>(GetPreguntasInspeccionCategoriaUseCase(sl()));
  sl.registerSingleton<GetThemeModeUseCase>(GetThemeModeUseCase(sl()));
  sl.registerSingleton<GetUserInfoUseCase>(GetUserInfoUseCase(sl()));

  // I
  sl.registerSingleton<IndexInspeccionUseCase>(IndexInspeccionUseCase(sl()));
  sl.registerSingleton<IndexUnidadUseCase>(IndexUnidadUseCase(sl()));

  // L
  sl.registerSingleton<ListCategoriaUseCase>(ListCategoriaUseCase(sl()));
  sl.registerSingleton<ListCategoriaItemUseCase>(ListCategoriaItemUseCase(sl()));
  sl.registerSingleton<ListInspeccionFicheroUseCase>(ListInspeccionFicheroUseCase(sl()));
  sl.registerSingleton<ListInspeccionTipoUseCase>(ListInspeccionTipoUseCase(sl()));
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase(sl()));

  // P
  sl.registerSingleton<PredictiveUnidadUseCase>(PredictiveUnidadUseCase(sl()));
  sl.registerSingleton<PredictiveEOSUnidadUseCase>(PredictiveEOSUnidadUseCase(sl()));

  // S
  sl.registerSingleton<SetThemeModeUseCase>(SetThemeModeUseCase(sl()));
  sl.registerSingleton<SignInUseCase>(SignInUseCase(sl()));
  sl.registerSingleton<StoreCategoriaUseCase>(StoreCategoriaUseCase(sl()));
  sl.registerSingleton<StoreCategoriaItemUseCase>(StoreCategoriaItemUseCase(sl()));
  sl.registerSingleton<StoreCredentialsUseCase>(StoreCredentialsUseCase(sl()));
  sl.registerSingleton<StoreDuplicateCategoriaItemUseCase>(StoreDuplicateCategoriaItemUseCase(sl()));
  sl.registerSingleton<StoreInspeccionSignatureUseCase>(StoreInspeccionSignatureUseCase(sl()));
  sl.registerSingleton<StoreInspeccionUseCase>(StoreInspeccionUseCase(sl()));
  sl.registerSingleton<StoreInspeccionCategoriaUseCase>(StoreInspeccionCategoriaUseCase(sl()));
  sl.registerSingleton<StoreInspeccionFicheroUseCase>(StoreInspeccionFicheroUseCase(sl()));
  sl.registerSingleton<StoreInspeccionTipoUseCase>(StoreInspeccionTipoUseCase(sl()));
  sl.registerSingleton<StoreUnidadUseCase>(StoreUnidadUseCase(sl()));
  sl.registerSingleton<StoreUserInfoUseCase>(StoreUserInfoUseCase(sl()));
  sl.registerSingleton<StoreUserSessionUseCase>(StoreUserSessionUseCase(sl()));

  // U
  sl.registerSingleton<UpdateCategoriaUseCase>(UpdateCategoriaUseCase(sl()));
  sl.registerSingleton<UpdateCategoriaItemUseCase>(UpdateCategoriaItemUseCase(sl()));
  sl.registerSingleton<UpdateDataSourcePersistenceUseCase>(UpdateDataSourcePersistenceUseCase(sl()));
  sl.registerSingleton<UpdateInspeccionTipoUseCase>(UpdateInspeccionTipoUseCase(sl()));

  /// ==================== STATE MANAGEMENT (BLOC) ==================== ///
  // (LOCAL OPERATIONS)
  sl.registerFactory<LocalAuthBloc>(() => LocalAuthBloc(sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<LocalSettingsBloc>(() => LocalSettingsBloc(sl(), sl()));

  // (REMOTE OPERATIONS)
  sl.registerFactory<RemoteAuthBloc>(() => RemoteAuthBloc(sl()));
  sl.registerFactory<RemoteCategoriaBloc>(() => RemoteCategoriaBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteCategoriaItemBloc>(() => RemoteCategoriaItemBloc(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteDataSourcePersistenceBloc>(() =>  RemoteDataSourcePersistenceBloc(sl()));
  sl.registerFactory<RemoteInspeccionBloc>(() => RemoteInspeccionBloc(sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteInspeccionCategoriaBloc>(() => RemoteInspeccionCategoriaBloc(sl(), sl()));
  sl.registerFactory<RemoteInspeccionFicheroBloc>(() => RemoteInspeccionFicheroBloc(sl(), sl(), sl()));
  sl.registerFactory<RemoteInspeccionTipoBloc>(() => RemoteInspeccionTipoBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteUnidadBloc>(() => RemoteUnidadBloc(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteUnidadEOSBloc>(() => RemoteUnidadEOSBloc(sl()));
}
