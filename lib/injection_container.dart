import 'package:eos_mobile/features/configuraciones/data/datasources/remote/inspecciones_remote_api_service.dart';
import 'package:eos_mobile/features/configuraciones/data/repositories/inspeccion_repository_impl.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_repository.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/get_inspecciones.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initializeDependencies() {
  // Dio
  sl..registerSingleton<Dio>(Dio())

  // Depdendencias
  ..registerSingleton<InspeccionesRemoteApiService>(InspeccionesRemoteApiService(sl()))

  ..registerSingleton<InspeccionRepository>(InspeccionRepositoryImpl(sl()))

  // Casos de uso
  ..registerSingleton<GetInspeccionesUseCase>(GetInspeccionesUseCase(sl()))

  // Blocs
  ..registerFactory<RemoteInspeccionesBloc>(() => RemoteInspeccionesBloc(sl()));
}
