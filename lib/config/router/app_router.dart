import 'package:eos_mobile/features/auth/presentation/pages/sign_in_page.dart';
import 'package:eos_mobile/layouts/app_scaffold.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/ui/pages/not_found/not_found_page.dart';
import 'package:eos_mobile/ui/pages/welcome/welcome_page.dart';
import 'package:flutter/foundation.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

/// Rutas compartidas / urls utilizadas en toda la aplicación.
class AppRoutes {
  static const String splash      = '/';
  static const String welcome     = '/welcome';
  static const String authSignIn  = '/sign-in';
}

final appRouter = GoRouter(
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
        AppRoute(AppRoutes.splash, (_) => const Scaffold(body: Center(child: CircularProgressIndicator()))),
        AppRoute(AppRoutes.welcome, (_) => const WelcomePage()),
        AppRoute(AppRoutes.authSignIn, (_) => const AuthSignInPage()),
      ],
    ),
  ],
);

/// Subclase GoRoute personalizada para facilitar la lectura de la declaración del router.
class AppRoute extends GoRoute {
  AppRoute(
    String path,
    Widget Function(GoRouterState s) builder, {
      List<GoRoute> routes  = const <GoRoute>[],
      this.useFade          = false,
  }) : super(
          path        : path,
          routes      : routes,
          pageBuilder : (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );
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

  if (appLogic.isBootstrapComplete && state.uri.path == AppRoutes.splash) {
    $logger.d('Redirigiendo desde ${state.uri.path} hasta ${AppRoutes.authSignIn}.');
    return AppRoutes.authSignIn;
  }

  if (!kIsWeb) debugPrint('Navegando a: ${state.uri}');

  return null; // no hacer nada
}
