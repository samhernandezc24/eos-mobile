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
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/inspeccion_tipo/inspeccion_tipo_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/remote/unidad/unidad_remote_api_service.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/categoria_item_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/categoria_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/inspeccion_tipo_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/data/repositories/unidad_repository_impl.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/delete_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/list_categorias_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/store_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/update_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/list_categorias_items_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/store_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspecciones_tipos/delete_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspecciones_tipos/list_inspecciones_tipos_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspecciones_tipos/store_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspecciones_tipos/update_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/create_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';

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
  sl.registerSingleton<CategoriaRemoteApiService>(CategoriaRemoteApiService(sl()));
  sl.registerSingleton<CategoriaItemRemoteApiService>(CategoriaItemRemoteApiService(sl()));
  sl.registerSingleton<UnidadRemoteApiService>(UnidadRemoteApiService(sl()));

  // Repositorios
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));
  sl.registerSingleton<InspeccionTipoRepository>(InspeccionTipoRepositoryImpl(sl()));
  sl.registerSingleton<CategoriaRepository>(CategoriaRepositoryImpl(sl()));
  sl.registerSingleton<CategoriaItemRepository>(CategoriaItemRepositoryImpl(sl()));
  sl.registerSingleton<UnidadRepository>(UnidadRepositoryImpl(sl()));

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
  sl.registerSingleton<StoreInspeccionTipoUseCase>(StoreInspeccionTipoUseCase(sl()));
  sl.registerSingleton<UpdateInspeccionTipoUseCase>(UpdateInspeccionTipoUseCase(sl()));
  sl.registerSingleton<DeleteInspeccionTipoUseCase>(DeleteInspeccionTipoUseCase(sl()));

  sl.registerSingleton<ListCategoriasUseCase>(ListCategoriasUseCase(sl()));
  sl.registerSingleton<StoreCategoriaUseCase>(StoreCategoriaUseCase(sl()));
  sl.registerSingleton<UpdateCategoriaUseCase>(UpdateCategoriaUseCase(sl()));
  sl.registerSingleton<DeleteCategoriaUseCase>(DeleteCategoriaUseCase(sl()));

  sl.registerSingleton<ListCategoriasItemsUseCase>(ListCategoriasItemsUseCase(sl()));
  sl.registerSingleton<StoreCategoriaItemUseCase>(StoreCategoriaItemUseCase(sl()));

  sl.registerSingleton<CreateUnidadUseCase>(CreateUnidadUseCase(sl()));

  // BLoCs
  sl.registerFactory<RemoteAuthBloc>(() => RemoteAuthBloc(sl()));
  sl.registerFactory<LocalAuthBloc>(() => LocalAuthBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory<RemoteInspeccionTipoBloc>(() => RemoteInspeccionTipoBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteCategoriaBloc>(() => RemoteCategoriaBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteCategoriaItemBloc>(() => RemoteCategoriaItemBloc(sl(), sl()));
  sl.registerFactory<RemoteUnidadBloc>(() => RemoteUnidadBloc(sl()));
}
