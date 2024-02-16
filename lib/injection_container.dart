// ignore_for_file: cascade_invocations

import 'package:dio/dio.dart';
import 'package:eos_mobile/features/auth/data/datasources/remote/login_api_service.dart';
import 'package:eos_mobile/features/auth/data/repositories/login_repository_impl.dart';
import 'package:eos_mobile/features/auth/domain/repositories/login_repository.dart';
import 'package:eos_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/login/remote/remote_login_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

/// Inyectar dependencias (lógica y servicios) que serán compartidos
/// a través de la aplicación.
Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencias
  sl.registerSingleton<LoginApiService>(LoginApiService(sl()));
  sl.registerSingleton<LoginRepository>(LoginRepositoryImpl(sl()));

  // Casos de Uso
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));

  // Blocs
  sl.registerFactory<RemoteLoginBloc>(() => RemoteLoginBloc(sl()));
}
