import 'package:eos_mobile/features/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/inspecciones_tipos/inspecciones_tipos_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/index/index_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/list/list_page.dart';
// import 'package:eos_mobile/features/inspecciones/presentation/pages/search_unidad/search_unidad_page.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

import 'package:eos_mobile/ui/pages/home/home_page.dart';
import 'package:eos_mobile/ui/pages/not_found/not_found_page.dart';
import 'package:eos_mobile/ui/pages/under_construction/under_construction_page.dart';
import 'package:eos_mobile/ui/pages/welcome/welcome_page.dart';
import 'package:flutter/foundation.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey     = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey    = GlobalKey<NavigatorState>(debugLabel: 'shell');
final GlobalKey<NavigatorState> _defaultNavigatorKey  = GlobalKey<NavigatorState>(debugLabel: 'defaultNav');

/// Rutas compartidas / urls utilizadas en toda la aplicación.
class ScreenPaths {
  static String splash        = '/';
  static String welcome       = '/welcome';
  static String authSignIn    = '/sign-in';
  static String home          = '/home';
  static String dashboard     = '/dashboard';
  static String activity      = '/actividad';
  static String notifications = '/notificaciones';
}

/// Tabla de enrutamiento, compara las rutas de las cadenas con las pantallas de la UI y,
/// opcionalmente, analiza los parámetros de las rutas.
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  redirect: _handleRedirect,
  debugLogDiagnostics: true,
  errorPageBuilder: (BuildContext context, GoRouterState state) => const MaterialPage(child: NotFoundPage()),
  routes: <RouteBase>[
    /// SPLASH SCREEN, ESTO SE OCULTARÁ
    AppRoute(ScreenPaths.splash, 'splash', (_) => const Scaffold(body: Center(child: CircularProgressIndicator()))),

    /// SHELL PARA LA NAVEGACIÓN DEL INICIO DE SESIÓN
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return AppScaffold(child: child);
      },
      routes: <RouteBase>[
        AppRoute(ScreenPaths.welcome, 'welcome', (_) => const WelcomePage()),
        AppRoute(ScreenPaths.authSignIn, 'signIn', (_) => const AuthSignInPage()),
      ],
    ),

    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        final String? routeName = GoRouterState.of(context).topRoute?.name;
        final String title = switch (routeName) {
          'home'                            => 'EOS Mobile',
          'dashboard'                       => 'Dashboard',
          'actividades'                     => 'Registro de actividades',
          'notificaciones'                  => 'Notificaciones',
          'home.inspecciones'               => 'Índice de inspecciones',
          'home.inspecciones.searchUnidad'  => 'Buscar unidad',
          'home.compras'                    => 'Órdenes de compras',
          'home.embarques'                  => 'Órdenes de embarques',
          'home.unidades'                   => 'Unidades',
          _                                 => 'Empty Page',
        };

        return AppScaffoldWithNavBar(title: title, navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: _defaultNavigatorKey,
          routes: <RouteBase>[
            AppRoute(ScreenPaths.home, 'home', (_) => const HomePage(), routes: <GoRoute>[
                AppRoute(
                  'inspecciones',
                  'home.inspecciones',
                  (_) => const InspeccionIndexPage(),
                  routes: <GoRoute>[
                    AppRoute(
                      'inspeccionesTipos',
                      'home.inspecciones.config.inspeccionesTipos',
                      (_) => const InspeccionConfiguracionInspeccionesTiposPage(),
                      parentKey: _rootNavigatorKey,
                    ),
                    AppRoute(
                      'list',
                      'home.inspecciones.list',
                      (_) => InspeccionListPage(),
                      useFade: true,
                      parentKey: _rootNavigatorKey,
                    ),
                    // AppRoute('searchunidad', 'home.inspecciones.searchUnidad', (_) => const InspeccionSearchUnidadPage(), useFade: true),
                    AppRoute('searchunidad', 'home.inspecciones.searchUnidad', (_) => const UnderConstructionPage(), useFade: true),
                  ],
                  useFade: true,
                ),

                AppRoute('compras', 'home.compras', (_) => const UnderConstructionPage(), useFade: true),
                AppRoute('embarques', 'home.embarques', (_) => const UnderConstructionPage(), useFade: true),
                AppRoute('unidades', 'home.unidades', (_) => const UnderConstructionPage(), useFade: true),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          routes: <RouteBase>[
            AppRoute(ScreenPaths.dashboard, 'dashboard', (_) => const UnderConstructionPage()),
          ],
        ),

        StatefulShellBranch(
          routes: <RouteBase>[
            AppRoute(ScreenPaths.activity, 'actividades', (_) => const UnderConstructionPage()),
          ],
        ),

        StatefulShellBranch(
          routes: <RouteBase>[
            AppRoute(ScreenPaths.notifications, 'notificaciones', (_) => const UnderConstructionPage()),
          ],
        ),
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
    GlobalKey<NavigatorState>? parentKey,
  }) : super(
          parentNavigatorKey: parentKey,
          path: path,
          name: name,
          routes: routes,
          pageBuilder: (BuildContext context, GoRouterState state) {
            final Widget pageContent = builder(state);

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

            return MaterialPage(child: pageContent);
          },
        );
  final bool useFade;
}

String? get initialDeeplink => _initialDeeplink;
String? _initialDeeplink;

String? _handleRedirect(BuildContext context, GoRouterState state) {
  // Si la aplicación no ha terminado de cargar y el usuario no está en la ruta
  // root, redirigirlo a la ruta root para completar la inicialización.
  //
  // Evita que alguien navegue fuera de `/` si la aplicación se está iniciando.
  if (!appLogic.isBootstrapComplete && state.uri.path != ScreenPaths.splash) {
    $logger.d('Redirigiendo desde ${state.uri.path} hasta ${ScreenPaths.splash}.');
    _initialDeeplink ??= state.uri.toString();
    return ScreenPaths.splash;
  }

  // Si la aplicación ha terminado de cargar y el usuario está en la ruta root,
  // redirigirlo a la página de signIn si no ha iniciado sesion.
  if (appLogic.isBootstrapComplete && state.uri.path == ScreenPaths.splash) {
    $logger.d('Redirigiendo desde ${state.uri.path} hasta ${ScreenPaths.authSignIn}.');
    return ScreenPaths.authSignIn;
  }

  if (!kIsWeb) $logger.d('Navegando a: ${state.uri}');
  return null; // no hacer nada
}
