import 'package:eos_mobile/core/common/pages/errors/error_404_page.dart';
import 'package:eos_mobile/core/common/pages/welcome/welcome_page.dart';
import 'package:eos_mobile/features/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:eos_mobile/features/home/presentation/home_page.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey   = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey  = GlobalKey<NavigatorState>(debugLabel: 'shell');

/// Tabla de enrutamiento, compara las rutas de las cadenas con las pantallas de la UI y,
/// opcionalmente, analiza los parámetros de las rutas.
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  errorPageBuilder: (BuildContext context, GoRouterState state) =>
      const MaterialPage<dynamic>(child: Error404Page()),
  routes: <RouteBase>[
    /// Application Shell
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget navigator) {
        return AppScaffold(child: navigator);
      },
      routes: <RouteBase>[
        AppRoute('/', 'splash', (_) => Container()),    // Esto será ocultado
        AppRoute('/home', 'home', (_) => const HomePage()),
        AppRoute('/sign-in', 'signIn', (_) => const AuthSignInPage()),
        AppRoute('/welcome', 'welcome', (_) => const WelcomePage()),
      ],
    ),
  ],
  redirect: _handleRedirect,
  // refreshListenable: _loginInfo,
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
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
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
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
}

String? get initialDeeplink => _initialDeeplink;
String? _initialDeeplink;

String? _handleRedirect(BuildContext context, GoRouterState state) {
  if (!appLogic.isBootstrapComplete && state.uri.path != '/') {
    $logger.d('Redirigiendo desde ${state.uri.path} a /');
    _initialDeeplink ??= state.uri.toString();
    return '/';
  }

  if (appLogic.isBootstrapComplete && state.uri.path == '/') {
    $logger.d('Redirigiendo desde ${state.uri.path} a /sign-in');
    return '/sign-in';
  }

  if (!kIsWeb) $logger.d('Navegando a: ${state.uri}');
  return null; // no hacer nada
}
