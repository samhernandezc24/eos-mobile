import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/remote/remote_sign_in_bloc.dart';
import 'package:eos_mobile/features/configuraciones/data/datasources/remote/categorias_remote_api_service.dart';
import 'package:eos_mobile/features/configuraciones/data/datasources/remote/inspecciones_remote_api_service.dart';
import 'package:eos_mobile/features/configuraciones/data/repositories/categoria_repository_impl.dart';
import 'package:eos_mobile/features/configuraciones/data/repositories/inspeccion_repository_impl.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/categoria_repository.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_repository.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/create_inspeccion_usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/get_categorias_by_id_inspeccion_usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/get_inspecciones_usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/remove_inspeccion_usecase.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/categorias/remote/remote_categorias_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

final sl = GetIt.instance;

/// Crear singletons y factories (lógica y servicios) que pueden ser compartidos a través de la aplicación.
Future<void> initializeDependencies() async {
  // Dio
  sl..registerSingleton<Dio>(Dio())

  // Controlador Top Level de la App
  // ignore: unnecessary_lambdas
  ..registerLazySingleton<AppLogic>(() => AppLogic())

  // ignore: unnecessary_lambdas
  ..registerLazySingleton<SettingsLogic>(() => SettingsLogic())

  // Depdendencias
  ..registerSingleton<AuthRemoteApiService>(AuthRemoteApiService(sl()))

  ..registerSingleton<InspeccionesRemoteApiService>(InspeccionesRemoteApiService(sl()))

  ..registerSingleton<CategoriasRemoteApiService>(CategoriasRemoteApiService(sl()))

  // Repositorios
  ..registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()))

  ..registerSingleton<InspeccionRepository>(InspeccionRepositoryImpl(sl()))

  ..registerSingleton<CategoriaRepository>(CategoriaRepositoryImpl(sl()))

  // Casos de uso
  ..registerSingleton<SignInUseCase>(SignInUseCase(sl()))

  // ..registerSingleton<GetInspeccionesUseCase>(GetInspeccionesUseCase(sl()))
  // ..registerSingleton<CreateInspeccionUseCase>(CreateInspeccionUseCase(sl()))
  // ..registerSingleton<RemoveInspeccionUseCase>(RemoveInspeccionUseCase(sl()))

  ..registerSingleton<GetCategoriasByIdUseCase>(GetCategoriasByIdUseCase(sl()))

  // Blocs
  ..registerFactory<RemoteSignInBloc>(() => RemoteSignInBloc(sl()))

  // ..registerFactory<RemoteInspeccionesBloc>(() => RemoteInspeccionesBloc(sl(),sl(),sl()))

  ..registerFactory<RemoteCategoriasBloc>(() => RemoteCategoriasBloc(sl()));
}
