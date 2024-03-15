import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/remote/remote_sign_in_bloc.dart';
import 'package:eos_mobile/features/configuraciones/data/datasources/remote/inspeccion_tipo_api_service.dart';
import 'package:eos_mobile/features/configuraciones/data/repositories/inspeccion_tipo_repository_impl.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_tipo_repository.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/create_inspeccion_tipo.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/fetch_inspeccion_tipo.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
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

  ..registerSingleton<InspeccionTipoApiService>(InspeccionTipoApiService(sl()))

  // Repositorios
  ..registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()))

  ..registerSingleton<InspeccionTipoRepository>(InspeccionTipoRepositoryImpl(sl()))

  // Casos de uso
  ..registerSingleton<SignInUseCase>(SignInUseCase(sl()))

  ..registerSingleton<FetchInspeccionTipoUseCase>(FetchInspeccionTipoUseCase(sl()))
  ..registerSingleton<CreateInspeccionTipoUseCase>(CreateInspeccionTipoUseCase(sl()))

  // Blocs
  ..registerFactory<RemoteSignInBloc>(() => RemoteSignInBloc(sl()))

  ..registerFactory<RemoteInspeccionTipoBloc>(() => RemoteInspeccionTipoBloc(sl(), sl()));
}
