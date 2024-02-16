import 'package:eos_mobile/config/router/app_router.dart';
import 'package:eos_mobile/config/theme/app_themes.dart';
import 'package:eos_mobile/injection_container.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Iniciar app.
  await initializeDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'EOS Mobile',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
    );
  }
}
