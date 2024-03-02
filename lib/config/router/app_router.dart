import 'package:eos_mobile/core/common/pages/empty/empty_page.dart';
import 'package:eos_mobile/features/account/presentation/pages/profile/profile_page.dart';
import 'package:eos_mobile/features/actividades/actividades_page.dart';
import 'package:eos_mobile/features/dashboard/dashboard_page.dart';
import 'package:eos_mobile/features/home/presentation/home_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/index/index_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/list/list_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/search_unidad/search_unidad_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/unidad_con_requerimiento/unidad_con_requerimiento_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/unidad_sin_requerimiento/unidad_sin_requerimiento_page.dart';
import 'package:eos_mobile/layouts/app_scaffold_with_navbar.dart';
import 'package:eos_mobile/shared/shared.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        final String? routeName = GoRouterState.of(context).topRoute?.name;
        final String title = switch (routeName) {
          'home' => 'EOS Mobile',
          'home.inspecciones' => 'Índice de Inspecciones',
          'home.inspecciones.list' => 'Lista de Inspecciones',
          'home.inspecciones.conrequerimiento' => 'Unidades con Requerimientos',
          'home.inspecciones.sinrequerimiento' => 'Inspección de Unidad Sin Req.',
          'home.inspecciones.searchunidad' => 'Buscar Unidad',
          _ => 'Desconocido',
        };
        return AppScaffoldWithNavBar(
          title: title,
          navigationShell: navigationShell,
        );
      },
      branches: <StatefulShellBranch>[
        // The route branch for the first tab of the bottom navigation bar.
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the first tab of the bottom navigation bar.
              name: 'home',
              path: '/home',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const HomePage(),
                  transitionDuration: $styles.times.pageTransition,
                  transitionsBuilder: (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child,
                  ) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOut)
                          .animate(animation),
                      child: child,
                    );
                  },
                );
              },
              // builder: (BuildContext context, GoRouterState state) =>
              //     const HomePage(),
              routes: <RouteBase>[
                GoRoute(
                  name: 'home.inspecciones',
                  path: 'inspecciones',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const InspeccionIndexPage(),
                      transitionDuration: $styles.times.pageTransition,
                      transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        return FadeTransition(
                          opacity: CurveTween(curve: Curves.easeInOut)
                              .animate(animation),
                          child: child,
                        );
                      },
                    );
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      name: 'home.inspecciones.list',
                      path: 'list',
                      pageBuilder: (BuildContext context, GoRouterState state) {
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: const InspeccionListPage(),
                          transitionDuration: $styles.times.pageTransition,
                          transitionsBuilder: (
                            BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child,
                          ) {
                            return FadeTransition(
                              opacity: CurveTween(curve: Curves.easeInOut)
                                  .animate(animation),
                              child: child,
                            );
                          },
                        );
                      },
                    ),
                    GoRoute(
                      name: 'home.inspecciones.conrequerimiento',
                      path: 'conrequerimiento',
                      pageBuilder: (BuildContext context, GoRouterState state) {
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: const InspeccionUnidadConRequerimientoPage(),
                          transitionDuration: $styles.times.pageTransition,
                          transitionsBuilder: (
                            BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child,
                          ) {
                            return FadeTransition(
                              opacity: CurveTween(curve: Curves.easeInOut)
                                  .animate(animation),
                              child: child,
                            );
                          },
                        );
                      },
                    ),
                    GoRoute(
                      name: 'home.inspecciones.sinrequerimiento',
                      path: 'sinrequerimiento',
                      pageBuilder: (BuildContext context, GoRouterState state) {
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: const InspeccionUnidadSinRequerimientoPage(),
                          transitionDuration: $styles.times.pageTransition,
                          transitionsBuilder: (
                            BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child,
                          ) {
                            return FadeTransition(
                              opacity: CurveTween(curve: Curves.easeInOut)
                                  .animate(animation),
                              child: child,
                            );
                          },
                        );
                      },
                    ),
                    GoRoute(
                      name: 'home.inspecciones.searchunidad',
                      path: 'searchunidad',
                      pageBuilder: (BuildContext context, GoRouterState state) {
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: const InspeccionSearchUnidadPage(),
                          transitionDuration: $styles.times.pageTransition,
                          transitionsBuilder: (
                            BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child,
                          ) {
                            return FadeTransition(
                              opacity: CurveTween(curve: Curves.easeInOut)
                                  .animate(animation),
                              child: child,
                            );
                          },
                        );
                      },
                    ),
                  ],
                  // builder: (BuildContext context, GoRouterState state) =>
                  //     const InspeccionIndexPage(),
                ),
                GoRoute(
                  name: 'home.compras',
                  path: 'compras',
                  builder: (BuildContext context, GoRouterState state) =>
                      const EmptyPage(),
                ),
                GoRoute(
                  name: 'home.requerimientos',
                  path: 'requerimientos',
                  builder: (BuildContext context, GoRouterState state) =>
                      const EmptyPage(),
                ),
              ],
            ),
          ],
        ),

        // The route branch for the second tab of the bottom navigation bar.
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the first tab of the bottom navigation bar.
              name: 'dashboard',
              path: '/dashboard',
              builder: (BuildContext context, GoRouterState state) =>
                  const DashboardPage(),
            ),
          ],
        ),

        // The route branch for the third tab of the bottom navigation bar.
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the first tab of the bottom navigation bar.
              name: 'actividades',
              path: '/actividades',
              builder: (BuildContext context, GoRouterState state) =>
                  const ActividadesPage(),
            ),
          ],
        ),

        // The route branch for the forth tab of the bottom navigation bar.
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the first tab of the bottom navigation bar.
              name: 'cuenta',
              path: '/cuenta',
              builder: (BuildContext context, GoRouterState state) =>
                  const AccountProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

// class ScreenPaths {
//   static String home = '/home';
//   static String welcome = '/welcome';
//   static String signIn = '/sign-in';
//   static String settings = '/settings';

//   static String inspeccionTipo = '$settings/inspecciones-tipo';
//   static String inspeccionTipoCreate = '$inspeccionTipo/create';

//   static String inspeccionesIndex = '/inspecciones';
//   static String inspeccionesList = '$inspeccionesIndex/list';

//   static String inspeccionDetails(String id) =>
//       _appendToCurrentPath('$inspeccionesIndex/$id');

//   static String _appendToCurrentPath(String newPath) {
//     final newPathUri = Uri.parse(newPath);
//     final currentUri = appRouter.routeInformationProvider.value.uri;
//     final Map<String, dynamic> params = Map.of(currentUri.queryParameters);
//     // ignore: cascade_invocations
//     params.addAll(newPathUri.queryParameters);
//     final Uri location = Uri(
//       path: '${currentUri.path}/${newPathUri.path}'.replaceAll('//', '/'),
//       queryParameters: params,
//     );
//     return location.toString();
//   }
// }

// final GoRouter appRouter = GoRouter(
//   redirect: _handleRedirect,
//   errorPageBuilder: (context, state) => const MaterialPage(
//     child: Error404Page(),
//   ),
//   routes: [
//     ShellRoute(
//       builder: (context, router, navigator) {
//         return AppScaffold(child: navigator);
//       },
//       routes: [
//         GoRoute(
//           path: '/',
//           pageBuilder: (context, state) {
//             return const MaterialPage(child: HomePage());
//           },
//           routes: [
//             GoRoute(
//               path: 'inspecciones',
//               pageBuilder: (context, state) {
//                 return CustomTransitionPage<void>(
//                   key: state.pageKey,
//                   child: const InspeccionIndexPage(),
//                   transitionsBuilder:
//                       (context, animation, secondaryAnimation, child) {
//                     return FadeTransition(
//                       opacity: animation,
//                       child: child,
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//         GoRoute(
//           path: '/sign-in',
//           pageBuilder: (context, state) {
//             return const MaterialPage(child: AuthSignInPage());
//           },
//         ),
//         GoRoute(
//           path: '/forgot-password',
//           pageBuilder: (context, state) {
//             return const MaterialPage(child: ForgotPasswordPage());
//           },
//         ),
//       ],
//     ),
//   ],
// );

// String? get initialDepplink => _initialDeeplink;
// String? _initialDeeplink;

// Future<String?> _handleRedirect(
//   BuildContext context,
//   GoRouterState state,
// ) async {
//   const secureStorage = FlutterSecureStorage();
//   final accessToken = await secureStorage.read(key: 'access_token');

//   if (accessToken != null && accessToken.isNotEmpty) {
//     debugPrint('Redireccionando desde ${state.uri.path} hasta el HomePage');
//     return '/';
//   } else {
//     debugPrint('Redireccionando desde ${state.uri.path} hasta el LoginPage');
//     return '/sign-in';
//   }
// }
