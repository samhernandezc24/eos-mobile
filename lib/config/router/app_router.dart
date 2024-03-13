import 'package:eos_mobile/core/common/pages/errors/error_404_page.dart';
import 'package:eos_mobile/core/common/pages/welcome/welcome_page.dart';
import 'package:eos_mobile/features/actividad/actividad_page.dart';
import 'package:eos_mobile/features/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:eos_mobile/features/cuenta/cuenta_profile_page.dart';
import 'package:eos_mobile/features/dashboard/dashboard_page.dart';
import 'package:eos_mobile/features/home/presentation/home_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/index/index_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/list/list_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/search_unidad/search_unidad_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/unidad_con_requerimiento/unidad_con_requerimiento_page.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// Rutas compartidas / urls utilizadas en toda la aplicación.
class ScreenPaths {
  static String splash                        = '/';
  static String welcome                       = '/welcome';
  static String authSignIn                    = '/sign-in';
  static String home                          = '/home';
  static String dashboard                     = '/dashboard';
  static String actividad                     = '/actividad';
  static String cuenta                        = '/cuenta';

  static String inspecciones                  = 'inspecciones';
  static String inspeccionesList              = 'list';
  static String inspeccionesConRequerimiento  = 'conrequerimiento';
  static String inspeccionesSearchUnidad      = 'searchunidad';

  /// Dynamically nested pages, always added on to the existing path

  static String _appendToCurrentPath(String newPath) {
    final Uri newPathUri = Uri.parse(newPath);
    final Uri currentUri = appRouter.routeInformationProvider.value.uri;

    final Map<String, dynamic> params = Map<String, dynamic>.of(currentUri.queryParameters)..addAll(newPathUri.queryParameters);

    final Uri location = Uri(path: '${currentUri.path}/${newPathUri.path}'.replaceAll('//', '/'), queryParameters: params);
    return location.toString();
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey   = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey  = GlobalKey<NavigatorState>(debugLabel: 'shell');

/// Tabla de enrutamiento, compara las rutas de las cadenas con las pantallas de la UI y,
/// opcionalmente, analiza los parámetros de las rutas.
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  redirect: _handleRedirect,
  debugLogDiagnostics: true,
  errorPageBuilder: (BuildContext context, GoRouterState state) => const MaterialPage<dynamic>(child: Error404Page()),
  routes: <RouteBase>[
    /// Application Shell
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        final String? routeName = GoRouterState.of(context).topRoute?.name;
        final String title = switch (routeName) {
          'home'                                => 'EOS Mobile',
          'dashboard'                           => 'Dashboard',
          'actividad'                           => 'Actividad',
          'cuenta'                              => 'Cuenta',
          'home.inspecciones'                   => 'Índice de Inspecciones',
          'home.inspecciones.list'              => 'Lista de Inspecciones',
          'home.inspecciones.conrequerimiento'  => 'Unidades con Requerimientos',
          'home.inspecciones.searchunidad'      => 'Buscar Unidad',
          _                                     => 'Empty Page',
        };

        return AppScaffold(title: title, child: child);
      },
      routes: <RouteBase>[
        AppRoute(ScreenPaths.splash, 'splash', (_) => Container()),
        AppRoute(ScreenPaths.authSignIn, 'signIn', (_) => const AuthSignInPage()),
        AppRoute(ScreenPaths.welcome, 'welcome', (_) => const WelcomePage()),
        AppRoute(
          ScreenPaths.home,
          'home',
          (_) => const HomePage(),
          routes: <GoRoute>[
            AppRoute(
              ScreenPaths.inspecciones,
              'home.inspecciones',
              (_) => const InspeccionIndexPage(),
              useFade: true,
              routes: <GoRoute>[
                AppRoute(
                  ScreenPaths.inspeccionesList,
                  'home.inspecciones.list',
                  (_) => const InspeccionListPage(),
                ),
                AppRoute(
                  ScreenPaths.inspeccionesConRequerimiento,
                  'home.inspecciones.conrequerimiento',
                  (_) => const InspeccionUnidadConRequerimientoPage(),
                ),
                AppRoute(
                  ScreenPaths.inspeccionesSearchUnidad,
                  'home.inspecciones.searchunidad',
                  (_) => const InspeccionSearchUnidadPage(),
                ),
              ],
            ),
          ],
        ),
        AppRoute(ScreenPaths.dashboard, 'dashboard', (_) => const DashboardPage()),
        AppRoute(ScreenPaths.actividad, 'actividad', (_) => const ActividadPage()),
        AppRoute(ScreenPaths.cuenta, 'cuenta', (_) => const CuentaProfilePage()),
      ],
    ),
  ],
);

/// Subclase GoRoute personalizada para facilitar la lectura de la declaración del router.
class AppRoute extends GoRoute {
  AppRoute(
    String path,
    String name,
    Widget Function(GoRouterState s) builder, {
    List<GoRoute> routes = const <GoRoute>[],
    this.useFade = false,
  }) : super(
          path: path,
          name: name,
          routes: routes,
          pageBuilder: (BuildContext context, GoRouterState state) {
            final Scaffold pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );
            if (useFade) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: pageContent,
                transitionDuration: $styles.times.pageTransition,
                transitionsBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child,
                ) {
                  // Cambiar la opacidad de la pantalla utilizando Curve
                  // basado en el valor de la animación.
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            }
            return CupertinoPage<dynamic>(child: pageContent);
          },
        );
  final bool useFade;
}

String? get initialDeeplink => _initialDeeplink;
String? _initialDeeplink;

String? _handleRedirect(BuildContext context, GoRouterState state) {
  final bool isBootstrapComplete = appLogic.isBootstrapComplete;

  // Si la aplicación no ha terminado de cargar y el usuario no está en la ruta
  // root, redirigirlo a la ruta root para completar la inicialización.
  //
  // Evita que alguien navegue fuera de `/` si la aplicación se está iniciando.
  if (!isBootstrapComplete && state.uri.path != ScreenPaths.splash) {
    $logger.d('Redirigiendo desde ${state.uri.path} hasta ${ScreenPaths.splash}.');
    _initialDeeplink ??= state.uri.toString();
    return ScreenPaths.splash;
  }

  // Si la aplicación ha terminado de cargar y el usuario está en la ruta root,
  // redirigirlo a la página de home si tiene su sesión activa, si no, lo
  // redirigmos a la página de inicio se sesión.
  if (appLogic.isBootstrapComplete && state.uri.path == ScreenPaths.splash) {
    if (settingsLogic.isLoggedIn.value == true) {
      $logger.d('Redirigiendo desde ${state.uri.path} hasta ${ScreenPaths.home}.');
      return ScreenPaths.home;
    } else {
      $logger.d('Redirigiendo desde ${state.uri.path} hasta ${ScreenPaths.authSignIn}.');
      return ScreenPaths.authSignIn;
    }
  }

  if (!kIsWeb) $logger.d('Navegando a: ${state.uri}');
  return null; // no hacer nada
}
