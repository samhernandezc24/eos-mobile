import 'package:eos_mobile/core/components/data_source_persistence/data/datasources/remote/data_source_persistence_remote_api_service.dart';
import 'package:eos_mobile/core/components/data_source_persistence/data/repositories/data_source_persistence_repository_impl.dart';
import 'package:eos_mobile/core/components/data_source_persistence/domain/repositories/data_source_persistence_repository.dart';
import 'package:eos_mobile/core/components/data_source_persistence/domain/usecases/update_data_source_persistence_usecase.dart';
import 'package:eos_mobile/core/components/data_source_persistence/presentation/bloc/remote/remote_data_source_persistence_bloc.dart';
import 'package:eos_mobile/core/helpers/auth_token_helper.dart';
import 'package:eos_mobile/core/helpers/image_helper.dart';

import 'package:eos_mobile/features/auth/data/datasources/local/auth_local_source.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
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
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/categoria/categoria_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/categoria_item/categoria_item_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion/inspeccion_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_categoria/inspeccion_categoria_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_fichero/inspeccion_fichero_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_tipo/inspeccion_tipo_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/unidad/unidad_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/categoria_item_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/categoria_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/inspeccion_categoria_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/inspeccion_fichero_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/inspeccion_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/inspeccion_tipo_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/unidad_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';
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
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/cancel_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/create_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/data_source_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/index_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/store_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_categoria/get_preguntas_inspeccion_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_categoria/store_inspeccion_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_fichero/list_inspeccion_fichero_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_fichero/store_inspeccion_fichero_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/delete_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/list_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/store_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/update_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/create_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/data_source_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/index_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/list_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/store_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_categoria/remote/remote_inspeccion_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_fichero/remote/remote_inspeccion_fichero_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

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
  // Helper para operaciones con el token de autenticacion
  sl.registerLazySingleton<AuthTokenHelper>(() => AuthTokenHelper());
  // Helper para operaciones con imágenes
  sl.registerLazySingleton<ImageHelper>(() => ImageHelper());
  // Configuraciones de usuario
  sl.registerLazySingleton<SettingsLogic>(() => SettingsLogic());

  // Servicios / Datasources
  sl.registerSingleton<AuthLocalSource>(AuthLocalSource());
  sl.registerSingleton<AuthRemoteApiService>(AuthRemoteApiService(sl()));

  sl.registerSingleton<CategoriaRemoteApiService>(CategoriaRemoteApiService(sl()));
  sl.registerSingleton<CategoriaItemRemoteApiService>(CategoriaItemRemoteApiService(sl()));

  sl.registerSingleton<DataSourcePersistenceRemoteApiService>(DataSourcePersistenceRemoteApiService(sl()));

  sl.registerSingleton<InspeccionRemoteApiService>(InspeccionRemoteApiService(sl()));
  sl.registerSingleton<InspeccionCategoriaRemoteApiService>(InspeccionCategoriaRemoteApiService(sl()));
  sl.registerSingleton<InspeccionFicheroRemoteApiService>(InspeccionFicheroRemoteApiService(sl()));
  sl.registerSingleton<InspeccionTipoRemoteApiService>(InspeccionTipoRemoteApiService(sl()));

  sl.registerSingleton<UnidadRemoteApiService>(UnidadRemoteApiService(sl()));

  // Repositorios
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));
  sl.registerSingleton<DataSourcePersistenceRepository>(DataSourcePersistenceRepositoryImpl(sl()));
  sl.registerSingleton<CategoriaRepository>(CategoriaRepositoryImpl(sl()));
  sl.registerSingleton<CategoriaItemRepository>(CategoriaItemRepositoryImpl(sl()));
  sl.registerSingleton<InspeccionRepository>(InspeccionRepositoryImpl(sl()));
  sl.registerSingleton<InspeccionCategoriaRepository>(InspeccionCategoriaRepositoryImpl(sl()));
  sl.registerSingleton<InspeccionFicheroRepository>(InspeccionFicheroRepositoryImpl(sl()));
  sl.registerSingleton<InspeccionTipoRepository>(InspeccionTipoRepositoryImpl(sl()));
  sl.registerSingleton<UnidadRepository>(UnidadRepositoryImpl(sl()));

  // Casos de uso
  sl.registerSingleton<CancelInspeccionUseCase>(CancelInspeccionUseCase(sl()));

  sl.registerSingleton<CreateInspeccionUseCase>(CreateInspeccionUseCase(sl()));
  sl.registerSingleton<CreateUnidadUseCase>(CreateUnidadUseCase(sl()));

  sl.registerSingleton<DataSourceInspeccionUseCase>(DataSourceInspeccionUseCase(sl()));
  sl.registerSingleton<DataSourceUnidadUseCase>(DataSourceUnidadUseCase(sl()));

  sl.registerSingleton<DeleteCategoriaUseCase>(DeleteCategoriaUseCase(sl()));
  sl.registerSingleton<DeleteCategoriaItemUseCase>(DeleteCategoriaItemUseCase(sl()));
  sl.registerSingleton<DeleteInspeccionTipoUseCase>(DeleteInspeccionTipoUseCase(sl()));

  sl.registerSingleton<GetCredentialsUseCase>(GetCredentialsUseCase(sl()));
  sl.registerSingleton<GetPreguntasInspeccionCategoriaUseCase>(GetPreguntasInspeccionCategoriaUseCase(sl()));
  sl.registerSingleton<GetUserInfoUseCase>(GetUserInfoUseCase(sl()));
  sl.registerSingleton<GetUserSessionUseCase>(GetUserSessionUseCase(sl()));

  sl.registerSingleton<IndexInspeccionUseCase>(IndexInspeccionUseCase(sl()));
  sl.registerSingleton<IndexUnidadUseCase>(IndexUnidadUseCase(sl()));

  sl.registerSingleton<ListCategoriaUseCase>(ListCategoriaUseCase(sl()));
  sl.registerSingleton<ListCategoriaItemUseCase>(ListCategoriaItemUseCase(sl()));
  sl.registerSingleton<ListInspeccionFicheroUseCase>(ListInspeccionFicheroUseCase(sl()));
  sl.registerSingleton<ListInspeccionTipoUseCase>(ListInspeccionTipoUseCase(sl()));
  sl.registerSingleton<ListUnidadUseCase>(ListUnidadUseCase(sl()));

  sl.registerSingleton<RemoveCredentialsUseCase>(RemoveCredentialsUseCase(sl()));
  sl.registerSingleton<RemoveUserInfoUseCase>(RemoveUserInfoUseCase(sl()));
  sl.registerSingleton<RemoveUserSessionUseCase>(RemoveUserSessionUseCase(sl()));

  sl.registerSingleton<SaveCredentialsUseCase>(SaveCredentialsUseCase(sl()));
  sl.registerSingleton<SaveUserInfoUseCase>(SaveUserInfoUseCase(sl()));
  sl.registerSingleton<SaveUserSessionUseCase>(SaveUserSessionUseCase(sl()));

  sl.registerSingleton<SignInUseCase>(SignInUseCase(sl()));

  sl.registerSingleton<StoreCategoriaUseCase>(StoreCategoriaUseCase(sl()));
  sl.registerSingleton<StoreCategoriaItemUseCase>(StoreCategoriaItemUseCase(sl()));
  sl.registerSingleton<StoreDuplicateCategoriaItemUseCase>(StoreDuplicateCategoriaItemUseCase(sl()));
  sl.registerSingleton<StoreInspeccionUseCase>(StoreInspeccionUseCase(sl()));
  sl.registerSingleton<StoreInspeccionCategoriaUseCase>(StoreInspeccionCategoriaUseCase(sl()));
  sl.registerSingleton<StoreInspeccionFicheroUseCase>(StoreInspeccionFicheroUseCase(sl()));
  sl.registerSingleton<StoreInspeccionTipoUseCase>(StoreInspeccionTipoUseCase(sl()));
  sl.registerSingleton<StoreUnidadUseCase>(StoreUnidadUseCase(sl()));

  sl.registerSingleton<UpdateCategoriaUseCase>(UpdateCategoriaUseCase(sl()));
  sl.registerSingleton<UpdateCategoriaItemUseCase>(UpdateCategoriaItemUseCase(sl()));
  sl.registerSingleton<UpdateDataSourcePersistenceUseCase>(UpdateDataSourcePersistenceUseCase(sl()));
  sl.registerSingleton<UpdateInspeccionTipoUseCase>(UpdateInspeccionTipoUseCase(sl()));

  // BLoCs
  sl.registerFactory<LocalAuthBloc>(() => LocalAuthBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory<RemoteAuthBloc>(() => RemoteAuthBloc(sl()));

  sl.registerFactory<RemoteCategoriaBloc>(() => RemoteCategoriaBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteCategoriaItemBloc>(() => RemoteCategoriaItemBloc(sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory<RemoteDataSourcePersistenceBloc>(() =>  RemoteDataSourcePersistenceBloc(sl()));

  sl.registerFactory<RemoteInspeccionBloc>(() => RemoteInspeccionBloc(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteInspeccionCategoriaBloc>(() => RemoteInspeccionCategoriaBloc(sl(), sl()));
  sl.registerFactory<RemoteInspeccionFicheroBloc>(() => RemoteInspeccionFicheroBloc(sl(), sl()));
  sl.registerFactory<RemoteInspeccionTipoBloc>(() => RemoteInspeccionTipoBloc(sl(), sl(), sl(), sl()));

  sl.registerFactory<RemoteUnidadBloc>(() => RemoteUnidadBloc(sl(), sl(), sl(), sl(), sl()));
}
