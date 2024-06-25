import 'package:eos_mobile/config/themes/app_theme.dart';
import 'package:eos_mobile/core/di/injection_container.dart';
import 'package:eos_mobile/core/helpers/auth_token_helper.dart';
import 'package:eos_mobile/core/helpers/image_helper.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/data_source_persistence/remote_data_source_persistence_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_categoria/remote/remote_inspeccion_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_fichero/remote/remote_inspeccion_fichero_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Mantener el splash nativo hasta que la app haya terminado de construirse.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // Iniciar las dependencias de la aplicación.
  await initializeDependencies();

  // Ejecutar la aplicación.
  runApp(MainApp());
  await appLogic.bootstrap();

  // Remover el splash nativo cuando la construcción de la app haya terminado.
  FlutterNativeSplash.remove();
}

/// Construcción de la aplicación usando el constructor [MaterialApp.router] y el constructor
/// global `appRouter`, una instancia de [GoRouter].
class MainApp extends StatelessWidget with GetItMixin {
  MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalAuthBloc>(create: (BuildContext context) => sl<LocalAuthBloc>()),
        BlocProvider<RemoteAuthBloc>(create: (BuildContext context) => sl<RemoteAuthBloc>()),
        BlocProvider<RemoteCategoriaBloc>(create: (BuildContext context) => sl<RemoteCategoriaBloc>()),
        BlocProvider<RemoteCategoriaItemBloc>(create: (BuildContext context) => sl<RemoteCategoriaItemBloc>()),
        BlocProvider<RemoteDataSourcePersistenceBloc>(create: (BuildContext context) => sl<RemoteDataSourcePersistenceBloc>()),
        BlocProvider<RemoteInspeccionBloc>(create: (BuildContext context) => sl<RemoteInspeccionBloc>()),
        BlocProvider<RemoteInspeccionCategoriaBloc>(create: (BuildContext context) => sl<RemoteInspeccionCategoriaBloc>()),
        BlocProvider<RemoteInspeccionFicheroBloc>(create: (BuildContext context) => sl<RemoteInspeccionFicheroBloc>()),
        BlocProvider<RemoteInspeccionTipoBloc>(create: (BuildContext context) => sl<RemoteInspeccionTipoBloc>()..add(ListInspeccionesTipos())),
        BlocProvider<RemoteUnidadBloc>(create: (BuildContext context) => sl<RemoteUnidadBloc>()..add(ListUnidades())),
      ],
      child: MaterialApp.router(
        title                       : $strings.defaultAppName,
        debugShowCheckedModeBanner  : false,
        theme                       : AppTheme.lightTheme($styles),
        darkTheme                   : AppTheme.darkTheme($styles),
        themeMode                   : ThemeMode.light,
        routeInformationProvider    : appRouter.routeInformationProvider,
        routeInformationParser      : appRouter.routeInformationParser,
        routerDelegate              : appRouter.routerDelegate,
      ),
    );
  }
}

/// Agregar "Syntactic Sugar" para acceder rápidamente a los principales controladores "lógicos" de la aplicación.
/// Deliberadamente no se crean shortcuts para los servicios, para desalentar su uso directamente en la capa de presentación.
AppLogic get appLogic                 => sl.get<AppLogic>();
SettingsLogic get settingsLogic       => sl.get<SettingsLogic>();
ImageHelper get imageHelper           => sl.get<ImageHelper>();
AuthTokenHelper get authTokenHelper   => sl.get<AuthTokenHelper>();

/// Helpers globales para facilitar la lectura del código.
AppStrings get $strings               => AppStrings.instance;
AppStyles get $styles                 => AppScaffold.styles;
Logger get $logger                    => Logger();
