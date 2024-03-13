import 'package:eos_mobile/core/common/widgets/app_scroll_behavior.dart';
import 'package:eos_mobile/shared/shared.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.title, required this.child, super.key});

  final String title;
  final Widget child;
  static AppStyles get style => _style;
  static final AppStyles _style = AppStyles();

  @override
  Widget build(BuildContext context) {
    // Escucha el tamaño del dispositivo y actualiza AppStyle cuando cambia.
    final mq = MediaQuery.of(context);
    appLogic.handleAppSizeChanged(mq.size);
    // Establecer el tiempo por defecto para las animaciones en la aplicación.
    Animate.defaultDuration = _style.times.fast;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: $styles.textStyles.h3,
        ),
        leading: _buildLeadingButton(context),
      ),
      body: KeyedSubtree(
        key: ValueKey($styles.scale),
        child: DefaultTextStyle(
          style: $styles.textStyles.body,
          // Utilizar un comportamiento de desplazamiento personalizado
          // en toda la aplicación.
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: child,
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.format_list_bulleted), label: 'Actividad'),
          NavigationDestination(icon: Icon(Icons.account_circle), label: 'Cuenta'),
        ],
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (int index) => _onItemTapped(context, index),
      ),
    );
  }

  Widget? _buildLeadingButton(BuildContext context) {
    final RouteMatchList currentConfiguration = GoRouter.of(context).routerDelegate.currentConfiguration;
    final RouteMatch lastMatch                = currentConfiguration.last;
    final Uri location                        = lastMatch is ImperativeRouteMatch ? lastMatch.matches.uri : currentConfiguration.uri;
    final bool canPop                         = location.pathSegments.length > 1;

    return canPop ? BackButton(onPressed: GoRouter.of(context).pop) : null;
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    if (location.startsWith(ScreenPaths.home)) {
      return 0;
    }
    if (location.startsWith(ScreenPaths.dashboard)) {
      return 1;
    }
    if (location.startsWith(ScreenPaths.actividad)) {
      return 2;
    }
    if (location.startsWith(ScreenPaths.cuenta)) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(ScreenPaths.home);
      case 1:
        GoRouter.of(context).go(ScreenPaths.dashboard);
      case 2:
        GoRouter.of(context).go(ScreenPaths.actividad);
      case 3:
        GoRouter.of(context).go(ScreenPaths.cuenta);
    }
  }
}
