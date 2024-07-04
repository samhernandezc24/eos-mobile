import 'package:eos_mobile/config/themes/theme_detector.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/features/settings/presentation/cubits/local/local_settings_cubit.dart';
import 'package:eos_mobile/injection_container.dart';
import 'package:eos_mobile/layouts/app_scaffold.dart';
import 'package:eos_mobile/layouts/app_scaffold_with_navbar.dart';
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
        BlocProvider<LocalSettingsCubit>(create: (context) => sl<LocalSettingsCubit>()),
        BlocProvider<RemoteAuthBloc>(create: (context) => sl<RemoteAuthBloc>()),
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

// Helpers globales para facilitar la lectura de código.
AppStyles get $stylesShell  => AppScaffold.styles;
AppStyles get $styles       => AppScaffoldWithNavBar.styles;
Logger get $logger          => Logger();
