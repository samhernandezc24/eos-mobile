import 'package:eos_mobile/config/themes/app_theme.dart';
import 'package:eos_mobile/core/di/injection_container.dart';
import 'package:eos_mobile/core/helpers/image_helper.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/single_child_widget.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Mantener el native splash screen hasta que la app haya terminado de construirse.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // Inicializar las dependencias de la aplicación.
  await initializeDependencies();

  // Ejecutar la aplicación.
  runApp(const MainApp());
  await appLogic.bootstrap();

  // Remover el splash screen cuando la construcción ha terminado.
  FlutterNativeSplash.remove();
}

/// Crea una app usando el constructor [MaterialApp.router] y el constructor
/// global `appRouter`, una instancia de [GoRouter].
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<SignInBloc>(
          create: (BuildContext context) => sl<SignInBloc>(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (_) => sl<AuthenticationBloc>(),
        ),
        BlocProvider<RemoteInspeccionTipoBloc>(
          create: (BuildContext context) => sl<RemoteInspeccionTipoBloc>()
              ..add(FetcInspeccionesTipos()),
        ),
        BlocProvider<RemoteCategoriaBloc>(
          create: (BuildContext context) => sl<RemoteCategoriaBloc>(),
        ),
      ],

      child: MaterialApp.router(
        title: 'EOS Mobile',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme($styles),
        darkTheme: AppTheme.darkTheme($styles),
        themeMode: ThemeMode.light,
        routeInformationProvider: appRouter.routeInformationProvider,
        routeInformationParser: appRouter.routeInformationParser,
        routerDelegate: appRouter.routerDelegate,
      ),
    );
  }
}

/// Agregar syntactic sugar para acceder rápidamente a los principales controladores
/// "lógicos" de la aplicación.
///
/// Deliberadamente no se crean shortcuts para los servicios, para desalentar su uso
/// directamente en la capa de presentación.
AppLogic get appLogic             =>  sl<AppLogic>();
SettingsLogic get settingsLogic   =>  sl<SettingsLogic>();
ImageHelper get imageHelper       => sl<ImageHelper>();

/// Helpers globales para facilitar la lectura de código
AppStrings get $strings   =>  AppStrings.instance;
AppStyles get $styles     =>  AppScaffold.style;
Logger get $logger        => Logger();
