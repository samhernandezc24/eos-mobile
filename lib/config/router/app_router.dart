import 'package:eos_mobile/core/common/pages/errors/error_404_page.dart';
import 'package:eos_mobile/features/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:eos_mobile/features/home/presentation/home_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class AppRouter {
  /// Tabla de routing, compara las rutas de las cadenas con las
  /// pantallas de la UI y, opcionalmente, analiza los parametros
  /// de las rutas.
  GoRouter appRouter = GoRouter(
    redirect: _handleRedirect,
    errorPageBuilder: (context, state) => const MaterialPage(
      child: Error404Page(),
    ),
    routes: [
      ShellRoute(
        builder: (context, router, navigator) {
          return AppScaffold(child: navigator);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) {
              return const MaterialPage(child: HomePage());
            },
          ),
          GoRoute(
            path: '/sign-in',
            pageBuilder: (context, state) {
              return const MaterialPage(child: AuthSignInPage());
            },
          ),
        ],
      ),
    ],
  );
}

String? get initialDepplink => _initialDeeplink;
String? _initialDeeplink;

Future<String?> _handleRedirect(BuildContext context, GoRouterState state) async {
  const secureStorage = FlutterSecureStorage();
  final accessToken = await secureStorage.read(key: 'access_token');

  if (accessToken != null && accessToken.isNotEmpty) {
    debugPrint('Redireccionando desde ${state.uri.path} hasta el HomePage');
    return '/';
  } else {
    debugPrint('Redireccionando desde ${state.uri.path} hasta el LoginPage');
    return '/sign-in';
  }
}
