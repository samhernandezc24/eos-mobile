import 'package:eos_mobile/features/auth/login_page.dart';
import 'package:eos_mobile/features/home/home_page.dart';
import 'package:eos_mobile/features/inspecciones/inspeccion_con_requerimientos_page.dart';
import 'package:eos_mobile/features/inspecciones/inspeccion_details_page.dart';
import 'package:eos_mobile/features/inspecciones/inspeccion_list_page.dart';
import 'package:eos_mobile/features/inspecciones/inspeccion_page.dart';
import 'package:eos_mobile/features/inspecciones/inspeccion_search_page.dart';
import 'package:eos_mobile/features/inspecciones/inspeccion_sin_requerimientos_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'EOS Mobile',
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const HomePage(),
          ),
          GoRoute(
            path: '/login',
            builder: (_, __) => const LoginPage(),
          ),
          GoRoute(
            path: '/inspecciones',
            builder: (_, __) => const InspeccionPage(),
            routes: [
              GoRoute(
                path: 'list',
                builder: (_, __) => const InspeccionListPage(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (_, __) => const InspeccionDetailsPage(),
                  ),
                ],
              ),
               GoRoute(
                path: 'con-requerimientos',
                builder: (_, __) => const InspeccionConRequerimientosPage(),
              ),
               GoRoute(
                path: 'sin-requerimientos',
                builder: (_, __) => const InspeccionSinRequerimientosPage(),
              ),
               GoRoute(
                path: 'search',
                builder: (_, __) => const InspeccionSearchPage(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
