import 'package:eos_mobile/config/themes/theme_detector.dart';
import 'package:eos_mobile/core/helpers/image_helper.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/cubit/local/local_auth_cubit.dart';
import 'package:eos_mobile/features/data_source_persistence/presentation/cubit/remote/remote_data_source_persistence_cubit.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/categoria/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/categoria_item/remote_categoria_item_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/inspeccion/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/inspeccion_tipo/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/unidad/remote_unidad_bloc.dart';
import 'package:eos_mobile/features/settings/presentation/cubit/local/local_settings_cubit.dart';
import 'package:eos_mobile/injection_container.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Mantener el splash nativo hasta que la app haya finalizado de construirse.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Configurar GoRouter para reflejar las APIs imperativas en la URL.
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // Iniciar las dependencias de la app.
  await initializeDependencies();

  // Ejecutar la aplicación.
  runApp(MainApp());
  await appLogic.bootstrap();

  // Remover el splash nativo cuando la construcción de la app haya finalizado.
  FlutterNativeSplash.remove();
}

class MainApp extends StatelessWidget with GetItMixin {
  MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteAuthBloc>(create: (context) => sl<RemoteAuthBloc>()),
        BlocProvider<RemoteInspeccionTipoBloc>(create: (context) => sl<RemoteInspeccionTipoBloc>()),
        BlocProvider<RemoteCategoriaBloc>(create: (context) => sl<RemoteCategoriaBloc>()),
        BlocProvider<RemoteCategoriaItemBloc>(create: (context) => sl<RemoteCategoriaItemBloc>()),
        BlocProvider<RemoteInspeccionBloc>(create: (context) => sl<RemoteInspeccionBloc>()),
        BlocProvider<RemoteUnidadBloc>(create: (context) => sl<RemoteUnidadBloc>()),
        BlocProvider<RemoteDataSourcePersistenceCubit>(create: (context) => sl<RemoteDataSourcePersistenceCubit>()),
        BlocProvider<LocalAuthCubit>(create: (context) => sl<LocalAuthCubit>()),
        BlocProvider<LocalSettingsCubit>(create: (context) => sl<LocalSettingsCubit>()),
      ],
      child: Builder(
        builder: (BuildContext context) {
          ThemeDetector.init(context);
          return BlocBuilder<LocalSettingsCubit, LocalSettingsState>(
            builder: (BuildContext themeContext, LocalSettingsState themeState) {
              return MaterialApp.router(
                title                       : AppStrings.defaultAppName,
                debugShowCheckedModeBanner  : false,
                theme                       : themeState.themeData,
                routerDelegate              : appRouter.routerDelegate,
                routeInformationParser      : appRouter.routeInformationParser,
                routeInformationProvider    : appRouter.routeInformationProvider,
              );
            },
          );
        },
      ),
    );
  }
}

// Agregar "Syntactic Sugar" para acceder rápidamente a los principales controladores "lógicos" de la aplicación.
// Deliberadamente no se crean shortcuts para los servicios, para desalentar su uso directamente en la capa de presentación.
AppLogic get appLogic             => sl.get<AppLogic>();
SettingsLogic get settingsLogic   => sl.get<SettingsLogic>();
ImageHelper get imageHelper       => sl.get<ImageHelper>();

// Helpers globales para facilitar la lectura de código.
AppStyles get $stylesShell  => AppScaffold.styles;
AppStyles get $styles       => AppScaffoldWithNavBar.styles;
Logger get $logger          => Logger();
