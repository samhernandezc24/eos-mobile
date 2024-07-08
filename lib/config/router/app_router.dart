import 'package:eos_mobile/features/auth/presentation/pages/sign_in_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/fotos/fotos.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/index/index_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/menu/menu_page.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/ui/pages/home/home_page.dart';
import 'package:eos_mobile/ui/pages/not_found/not_found_page.dart';
import 'package:eos_mobile/ui/pages/under_construction/under_construction_page.dart';
import 'package:eos_mobile/ui/pages/welcome/welcome_page.dart';
import 'package:flutter/foundation.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey     = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey    = GlobalKey<NavigatorState>(debugLabel: 'shell');

/// Rutas compartidas / urls utilizadas en toda la aplicación.
class AppRoutes {
  static const String splash          = '/';
  static const String welcome         = '/welcome';
  static const String authSignIn      = '/sign-in';
  static const String home            = '/home';
  static const String dashboard       = '/dashboard';
  static const String actividades     = '/actividades';
  static const String notificaciones  = '/notificaciones';
}

/// Tabla de routing, compara las rutas de las cadenas con las pantallas de la UI y,
/// opcionalmente, analiza los parámetros de las rutas.
final appRouter = GoRouter(
  navigatorKey      : _rootNavigatorKey,
  redirect          : _handleRedirect,
  errorPageBuilder  : (BuildContext context, GoRouterState state) => const MaterialPage(child: NotFoundPage()),
  routes            : <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, router, navigator) {
        return AppScaffold(child: navigator);
      },
      routes: <RouteBase>[
        // SPLASH PAGE, SE OCULTARA:
        AppRoute(AppRoutes.splash, 'splash', (_) => const Scaffold(body: Center(child: CircularProgressIndicator()))),
        AppRoute(AppRoutes.welcome, 'welcome', (_) => const WelcomePage()),
        AppRoute(AppRoutes.authSignIn, 'signIn', (_) => const AuthSignInPage()),
      ],
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        final String? routeName = GoRouterState.of(context).topRoute?.name;
        final String title = switch (routeName) {
          'home'                            => 'EOS Mobile',
          'home.inspecciones'               => 'Módulo de inspecciones',
          'home.inspecciones.searchUnidad'  => 'Unidades',
          'home.inspecciones.fotos'         => 'Fotos',
          'home.compras'                    => 'Módulo de compras',
          'home.embarques'                  => 'Módulo de embarques',
          'home.unidades'                   => 'Módulo de unidades',
          'dashboard'                       => 'Dashboard',
          'actividades'                     => 'Registro de actividades',
          'notificaciones'                  => 'Notificaciones',
          _                                 => '',
        };

        return AppScaffoldWithNavBar(title: title, navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            AppRoute(
              // HOME PAGE
              AppRoutes.home, 'home', (_) => const HomePage(), routes: [
                // INSPECCIONES PAGE
                AppRoute(
                  'inspecciones',
                  'home.inspecciones',
                  (_) => const InspeccionMenuPage(),
                  routes: <GoRoute>[
                    // INSPECCIONES INDEX PAGE
                    AppRoute(
                      'index',
                      'home.inspecciones.index',
                      (_) => const InspeccionIndexPage(),
                      parentKey: _rootNavigatorKey,
                      useFade: true,
                    ),
                    // INSPECCIONES SEARCH UNIDAD PAGE
                    AppRoute(
                      'search-unidad',
                      'home.inspecciones.searchUnidad',
                      (_) => const UnderConstructionPage(),
                      // parentKey: _rootNavigatorKey,
                      useFade: true,
                    ),
                    // PRUEBA DE FOTOGRAFIAS
                    AppRoute(
                      'fotos',
                      'home.inspecciones.fotos',
                      (_) => const FotosPage(),
                      // parentKey: _rootNavigatorKey,
                      useFade: true,
                    ),
                  ],
                  useFade: true,
                ),
                // COMPRAS PAGE
                AppRoute('compras', 'home.compras', (_) => const UnderConstructionPage(), useFade: true),
                // EMBARQUES PAGE
                AppRoute('embarques', 'home.embarques', (_) => const UnderConstructionPage(), useFade: true),
                // UNIDADES PAGE
                AppRoute('unidades', 'home.unidades', (_) => const UnderConstructionPage(), useFade: true),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            // DASHBOARD PAGE
            AppRoute(AppRoutes.dashboard, 'dashboard', (_) => const UnderConstructionPage()),
          ],
        ),

        StatefulShellBranch(
          routes: [
            // ACTIVIDADES PAGE
            AppRoute(AppRoutes.actividades, 'actividades', (_) => const UnderConstructionPage()),
          ],
        ),

        StatefulShellBranch(
          routes: [
            // NOTIFICACIONES PAGE
            AppRoute(AppRoutes.notificaciones, 'notificaciones', (_) => const UnderConstructionPage()),
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
      GlobalKey<NavigatorState>? parentKey,
      List<GoRoute> routes  = const <GoRoute>[],
      this.useFade          = false,
  }) : super(
          path: path,
          name: name,
          routes: routes,
          pageBuilder: (BuildContext context, GoRouterState state) {
            final pageContent = builder(state);
            if (useFade) {
              return CustomTransitionPage(
                key                 : state.pageKey,
                child               : pageContent,
                transitionsBuilder  : (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return MaterialPage(child: pageContent);
          },
          parentNavigatorKey: parentKey,
        );

  final bool useFade;
}

// PROPERTIES
String? get initialDeeplink => _initialDeeplink;
String? _initialDeeplink;

String? _handleRedirect(BuildContext context, GoRouterState state) {
  // Si la aplicación no ha terminado de cargar y el usuario no está en la ruta
  // root, redirigirlo a la ruta root para completar la inicialización.
  //
  // Esto evita un bucle de redirección innecesario si ya estás en la página de splash.
  if (!appLogic.isBootstrapComplete && state.uri.path != AppRoutes.splash) {
    $logger.d('Redirigiendo desde ${state.uri.path} hasta ${AppRoutes.splash}.');
    _initialDeeplink ??= state.uri.toString();
    return AppRoutes.splash;
  }

  // Si la aplicación ha terminado de cargar y el usuario está en la ruta root,
  // redirigirlo a la página de signIn si no ha iniciado sesion.
  if (appLogic.isBootstrapComplete && state.uri.path == AppRoutes.splash && settingsLogic.hasAuthenticated.value == false) {
    $logger.d('Redirigiendo desde ${state.uri.path} hasta ${AppRoutes.authSignIn}.');
    return AppRoutes.authSignIn;
  }

  if (!kIsWeb) debugPrint('Navegando a: ${state.uri}');
  return null; // no hacer nada
}
