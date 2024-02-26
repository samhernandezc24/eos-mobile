import 'package:eos_mobile/config/router/app_router.dart';
import 'package:eos_mobile/config/themes/app_theme.dart';
import 'package:eos_mobile/core/injection_container.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/remote/remote_sign_in_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/create/remote/remote_create_inspeccion_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_event.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Mantener el native splash screen hasta que la app haya terminado de construirse
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // GoRouter.optionURLReflectsImperativeAPIs = true;

  // Iniciar la app
  await initializeDependencies();

  runApp(const MainApp());

  // Remover el splash screen cuando la construcción ha terminado
  FlutterNativeSplash.remove();
}

/// Creates an app using the [MaterialApp.router] constructor and the
/// global `appRouter`, an instance of [GoRouter].
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteSignInBloc>(
          create: (context) =>
              sl<RemoteSignInBloc>(),
        ),
        BlocProvider<RemoteInspeccionesBloc>(
          create: (context) =>
              sl<RemoteInspeccionesBloc>()..add(const GetInspecciones()),
        ),
        BlocProvider<RemoteCreateInspeccionBloc>(
          create: (context) => sl<RemoteCreateInspeccionBloc>(),
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

/// Global helpers for readability
AppStrings get $strings => AppStrings.instance;
AppStyles get $styles => AppScaffold.style;
