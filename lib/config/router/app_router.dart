import 'package:eos_mobile/core/common/pages/errors/error_404_page.dart';
import 'package:eos_mobile/core/common/pages/welcome/welcome_page.dart';
import 'package:eos_mobile/features/home/presentation/home_page.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey   = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey  = GlobalKey<NavigatorState>(debugLabel: 'shell');

/// Tabla de enrutamiento, compara las rutas de las cadenas con las pantallas de la UI y,
/// opcionalmente, analiza los parámetros de las rutas.
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  errorPageBuilder: (BuildContext context, GoRouterState state) =>
      const MaterialPage(child: Error404Page()),
  routes: <RouteBase>[
    /// Application Shell
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return AppScaffold(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: '/welcome',
          builder: (BuildContext context, GoRouterState state) {
            return const WelcomePage();
          },
        ),
      ],
    ),
  ],
  // redirect: (BuildContext context, GoRouterState state) {
  //   final bool isAuthenticated;

  //   // if (isAuthenticated) {
  //   //   return '/home';
  //   // } else {
  //   //   return '/login';
  //   // }
  // },
  // refreshListenable: _loginInfo,
);

/// Subclase GoRoute personalizada para facilitar la lectura de la declaración del router.
class AppRoute extends GoRoute {
  AppRoute(
    String path,
    String name,
    Widget Function(GoRouterState s) builder, {
    List<GoRoute> routes = const [],
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

// final GoRouter appRouter = GoRouter(
//   navigatorKey: _rootNavigatorKey,
//   initialLocation: '/home',
//   debugLogDiagnostics: true,
//   routes: <RouteBase>[
//     StatefulShellRoute.indexedStack(
//       builder: (
//         BuildContext context,
//         GoRouterState state,
//         StatefulNavigationShell navigationShell,
//       ) {
//         final String? routeName = GoRouterState.of(context).topRoute?.name;
//         final String title = switch (routeName) {
//           'home'                                => 'EOS Mobile',
//           'home.inspecciones'                   => 'Índice de Inspecciones',
//           'home.inspecciones.list'              => 'Lista de Inspecciones',
//           'home.inspecciones.conrequerimiento'  => 'Unidades con Requerimientos',
//           'home.inspecciones.searchunidad'      => 'Buscar Unidad',
//           _ => 'Empty Page',
//         };
//         return AppScaffoldWithNavBar(
//           title: title,
//           navigationShell: navigationShell,
//         );
//       },
//       branches: <StatefulShellBranch>[
//         // The route branch for the first tab of the bottom navigation bar.
//         StatefulShellBranch(
//           navigatorKey: _shellNavigatorKey,
//           routes: <RouteBase>[
//             GoRoute(
//               // The screen to display as the root in the first tab of the bottom navigation bar.
//               name: 'home',
//               path: '/home',
//               pageBuilder: (BuildContext context, GoRouterState state) {
//                 return CustomTransitionPage<void>(
//                   key: state.pageKey,
//                   child: const AuthSignInPage(),
//                   transitionDuration: $styles.times.pageTransition,
//                   transitionsBuilder: (
//                     BuildContext context,
//                     Animation<double> animation,
//                     Animation<double> secondaryAnimation,
//                     Widget child,
//                   ) {
//                     return FadeTransition(
//                       opacity: CurveTween(curve: Curves.easeInOut)
//                           .animate(animation),
//                       child: child,
//                     );
//                   },
//                 );
//               },
//               routes: <RouteBase>[
//                 GoRoute(
//                   name: 'home.inspecciones',
//                   path: 'inspecciones',
//                   pageBuilder: (BuildContext context, GoRouterState state) {
//                     return CustomTransitionPage<void>(
//                       key: state.pageKey,
//                       child: const InspeccionIndexPage(),
//                       transitionDuration: $styles.times.pageTransition,
//                       transitionsBuilder: (BuildContext context,
//                           Animation<double> animation,
//                           Animation<double> secondaryAnimation,
//                           Widget child) {
//                         return FadeTransition(
//                           opacity: CurveTween(curve: Curves.easeInOut)
//                               .animate(animation),
//                           child: child,
//                         );
//                       },
//                     );
//                   },
//                   routes: <RouteBase>[
//                     GoRoute(
//                       name: 'home.inspecciones.list',
//                       path: 'list',
//                       pageBuilder: (BuildContext context, GoRouterState state) {
//                         return CustomTransitionPage<void>(
//                           key: state.pageKey,
//                           child: const InspeccionListPage(),
//                           transitionDuration: $styles.times.pageTransition,
//                           transitionsBuilder: (
//                             BuildContext context,
//                             Animation<double> animation,
//                             Animation<double> secondaryAnimation,
//                             Widget child,
//                           ) {
//                             return FadeTransition(
//                               opacity: CurveTween(curve: Curves.easeInOut)
//                                   .animate(animation),
//                               child: child,
//                             );
//                           },
//                         );
//                       },
//                     ),
//                     GoRoute(
//                       name: 'home.inspecciones.conrequerimiento',
//                       path: 'conrequerimiento',
//                       pageBuilder: (BuildContext context, GoRouterState state) {
//                         return CustomTransitionPage<void>(
//                           key: state.pageKey,
//                           child: const InspeccionUnidadConRequerimientoPage(),
//                           transitionDuration: $styles.times.pageTransition,
//                           transitionsBuilder: (
//                             BuildContext context,
//                             Animation<double> animation,
//                             Animation<double> secondaryAnimation,
//                             Widget child,
//                           ) {
//                             return FadeTransition(
//                               opacity: CurveTween(curve: Curves.easeInOut)
//                                   .animate(animation),
//                               child: child,
//                             );
//                           },
//                         );
//                       },
//                     ),
//                     GoRoute(
//                       name: 'home.inspecciones.searchunidad',
//                       path: 'searchunidad',
//                       pageBuilder: (BuildContext context, GoRouterState state) {
//                         return CustomTransitionPage<void>(
//                           key: state.pageKey,
//                           child: const InspeccionSearchUnidadPage(),
//                           transitionDuration: $styles.times.pageTransition,
//                           transitionsBuilder: (
//                             BuildContext context,
//                             Animation<double> animation,
//                             Animation<double> secondaryAnimation,
//                             Widget child,
//                           ) {
//                             return FadeTransition(
//                               opacity: CurveTween(curve: Curves.easeInOut)
//                                   .animate(animation),
//                               child: child,
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//                 GoRoute(
//                   name: 'home.compras',
//                   path: 'compras',
//                   builder: (BuildContext context, GoRouterState state) =>
//                       const EmptyPage(),
//                 ),
//                 GoRoute(
//                   name: 'home.requerimientos',
//                   path: 'requerimientos',
//                   builder: (BuildContext context, GoRouterState state) =>
//                       const EmptyPage(),
//                 ),
//               ],
//             ),
//           ],
//         ),

//         // The route branch for the second tab of the bottom navigation bar.
//         StatefulShellBranch(
//           routes: <RouteBase>[
//             GoRoute(
//               // The screen to display as the root in the first tab of the bottom navigation bar.
//               name: 'dashboard',
//               path: '/dashboard',
//               builder: (BuildContext context, GoRouterState state) =>
//                   const DashboardPage(),
//             ),
//           ],
//         ),

//         // The route branch for the third tab of the bottom navigation bar.
//         StatefulShellBranch(
//           routes: <RouteBase>[
//             GoRoute(
//               // The screen to display as the root in the first tab of the bottom navigation bar.
//               name: 'actividades',
//               path: '/actividades',
//               builder: (BuildContext context, GoRouterState state) =>
//                   const ActividadesPage(),
//             ),
//           ],
//         ),

//         // The route branch for the forth tab of the bottom navigation bar.
//         StatefulShellBranch(
//           routes: <RouteBase>[
//             GoRoute(
//               // The screen to display as the root in the first tab of the bottom navigation bar.
//               name: 'cuenta',
//               path: '/cuenta',
//               builder: (BuildContext context, GoRouterState state) =>
//                   const AccountProfilePage(),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// );
