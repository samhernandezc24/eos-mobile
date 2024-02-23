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
  ..registerSingleton<InspeccionesRemoteApiService>(InspeccionesRemoteApiService(sl()))

  ..registerSingleton<InspeccionRepository>(InspeccionRepositoryImpl(sl()))

  // Casos de uso
  ..registerSingleton<GetInspeccionesUseCase>(GetInspeccionesUseCase(sl()))
  ..registerSingleton<CreateInspeccionUseCase>(CreateInspeccionUseCase(sl()))

  // Blocs
  ..registerFactory<RemoteInspeccionesBloc>(() => RemoteInspeccionesBloc(sl()))
  ..registerFactory<RemoteCreateInspeccionBloc>(() => RemoteCreateInspeccionBloc(sl()));
}
