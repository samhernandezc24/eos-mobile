import 'package:eos_mobile/features/auth/data/datasources/remote/auth_remote_api_service.dart';
import 'package:eos_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/remote/remote_sign_in_bloc.dart';
import 'package:eos_mobile/features/configuraciones/data/datasources/remote/inspecciones_remote_api_service.dart';
import 'package:eos_mobile/features/configuraciones/data/repositories/inspeccion_repository_impl.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_repository.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/create_inspeccion.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/get_inspecciones.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/create/remote/remote_create_inspeccion_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

final sl = GetIt.instance;

/// Crear singletons y factories (lógica y servicios) que pueden ser compartidos a través de la aplicación.
Future<void> initializeDependencies() async {
  // Dio
  sl..registerSingleton<Dio>(Dio())

  // Depdendencias
  ..registerSingleton<AuthRemoteApiService>(AuthRemoteApiService(sl()))
  ..registerSingleton<InspeccionesRemoteApiService>(InspeccionesRemoteApiService(sl()))


  // Repositorios
  ..registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()))
  ..registerSingleton<InspeccionRepository>(InspeccionRepositoryImpl(sl()))

  // Casos de uso
  ..registerSingleton<SignInUseCase>(SignInUseCase(sl()))
  ..registerSingleton<GetInspeccionesUseCase>(GetInspeccionesUseCase(sl()))
  ..registerSingleton<CreateInspeccionUseCase>(CreateInspeccionUseCase(sl()))

  // Blocs
  ..registerFactory<RemoteSignInBloc>(() => RemoteSignInBloc(sl()))
  ..registerFactory<RemoteInspeccionesBloc>(() => RemoteInspeccionesBloc(sl()))
  ..registerFactory<RemoteCreateInspeccionBloc>(() => RemoteCreateInspeccionBloc(sl()));
}
