import 'package:eos_mobile/features/auth/presentation/pages/login/login_page.dart';
import 'package:eos_mobile/features/home/home_page.dart';
import 'package:eos_mobile/features/inspecciones/inspeccion_con_requerimientos_page.dart';
import 'package:eos_mobile/features/inspecciones/inspeccion_details_page.dart';
import 'package:eos_mobile/features/inspecciones/inspeccion_list_page.dart';
import 'package:eos_mobile/features/inspecciones/inspeccion_page.dart';
import 'package:eos_mobile/features/inspecciones/inspeccion_search_page.dart';
import 'package:eos_mobile/features/inspecciones/inspeccion_sin_requerimientos_page.dart';
import 'package:eos_mobile/ui/pages/error_404_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenPaths {
  static String home = '/home';
  static String login = '/login';
  static String inspecciones = '/home/inspecciones';
}

final appRouter = GoRouter(
  errorPageBuilder: (context, state) =>
      MaterialPage(child: Error404Page(state.uri.toString())),
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'inspecciones',
      path: '/inspecciones',
      builder: (context, state) => const InspeccionPage(),
      routes: [
        GoRoute(
          name: 'inspecciones-lista',
          path: 'list',
          builder: (context, state) => const InspeccionListPage(),
          routes: [
            GoRoute(
              name: 'inspecciones-detalles',
              path: ':id',
              builder: (context, state) => const InspeccionDetailsPage(),
            ),
          ],
        ),
        GoRoute(
          name: 'inspecciones-sin-requerimientos',
          path: 'sin-requerimientos',
          builder: (context, state) => const InspeccionSinRequerimientosPage(),
        ),
        GoRoute(
          name: 'inspecciones-con-requerimientos',
          path: 'con-requerimientos',
          builder: (context, state) => const InspeccionConRequerimientosPage(),
        ),
        GoRoute(
          name: 'inspecciones-buscador',
          path: 'search',
          builder: (context, state) => const InspeccionSearchPage(),
        ),
      ],
    ),
  ],
);

class AppRoute extends GoRoute {
  AppRoute(
    String path,
    Widget Function(GoRouterState state) builder, {
    List<GoRoute> routes = const [],
    this.useFade = false,
  }) : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );

            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );

  final bool useFade;
}