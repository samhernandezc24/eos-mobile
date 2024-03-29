import 'package:eos_mobile/config/themes/app_theme.dart';
import 'package:eos_mobile/core/di/injection_container.dart';
import 'package:eos_mobile/core/helpers/image_helper.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Mantener el splash nativo hasta que la app haya terminado de construirse.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // Iniciar las dependencias de la aplicación.
  await initializeDependencies();

  // Ejecutar la aplicación.
  runApp(const MainApp());
  // await appLogic.bootstrap();

  // Remover el splash nativo cuando la construcción de la app haya terminado.
  FlutterNativeSplash.remove();
}

/// Construcción de la aplicación usando el constructor [MaterialApp.router] y el constructor
/// global `appRouter`, una instancia de [GoRouter].
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => sl<RemoteAuthBloc>()),
        BlocProvider(create: (BuildContext context) => sl<LocalAuthBloc>()),
      ],
      child: MaterialApp(
        title: $strings.defaultAppName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme($styles),
        darkTheme: AppTheme.darkTheme($styles),
        themeMode: ThemeMode.light,
        home: const AuthSignInPage(),
      ),
      // child: MaterialApp.router(
      //   title: $strings.defaultAppName,
      //   debugShowCheckedModeBanner: false,
      //   theme: AppTheme.lightTheme($styles),
      //   darkTheme: AppTheme.darkTheme($styles),
      //   themeMode: ThemeMode.light,
      //   routeInformationProvider: appRouter.routeInformationProvider,
      //   routeInformationParser: appRouter.routeInformationParser,
      //   routerDelegate: appRouter.routerDelegate,
      // ),
    );
  }
}

/// Agregar "Syntactic Sugar" para acceder rápidamente a los principales controladores "lógicos" de la aplicación.
/// Deliberadamente no se crean shortcuts para los servicios, para desalentar su uso directamente en la capa de presentación.
AppLogic get appLogic           => sl.get<AppLogic>();
SettingsLogic get settingsLogic => sl.get<SettingsLogic>();
ImageHelper get imageHelper     => sl.get<ImageHelper>();

/// Helpers globales para facilitar la lectura del código.
AppStrings get $strings         => AppStrings.instance;
AppStyles get $styles           => AppScaffold.styles;
Logger get $logger              => Logger();
