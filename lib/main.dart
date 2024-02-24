import 'package:eos_mobile/config/themes/app_theme.dart';
import 'package:eos_mobile/core/injection_container.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/remote/remote_sign_in_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/create/remote/remote_create_inspeccion_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_event.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();
  // Mantener el native splash screen hasta que la app haya terminado de construirse
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // GoRouter.optionURLReflectsImperativeAPIs = true;

  // Iniciar la app
  await initializeDependencies();

  runApp(const MainApp());

  // Remover el splash screen cuando la construcción ha terminado
  FlutterNativeSplash.remove();
}

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
      child: MaterialApp(
        title: 'EOS Mobile',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const AuthSignInPage(),
      ),
    );
  }
}
