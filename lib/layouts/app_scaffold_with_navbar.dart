import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/ui/common/app_scroll_behavior.dart';

class AppScaffoldWithNavBar extends StatelessWidget {
  const AppScaffoldWithNavBar({
    required this.title,
    required this.navigationShell,
    Key? key,
  }) : super(key: key);

  final String title;
  final StatefulNavigationShell navigationShell;

  static AppStyles get styles => _styles;
  static AppStyles _styles = AppStyles();

  @override
  Widget build(BuildContext context) {
    // Escucha el tamaño del dispositivo y actualiza AppStyle cuando cambia.
    final mq = MediaQuery.of(context);
    appLogic.handleAppSizeChanged(mq.size);

    // Crear un objeto de estilo que se pasará al árbol de widgets.
    _styles = AppStyles(screenSize: context.sizePx);

    // Establecer el tiempo por defecto para las animaciones en la aplicación.
    Animate.defaultDuration = _styles.times.fast;

    return KeyedSubtree(
      key: ValueKey($styles.scale),
      child: DefaultTextStyle(
        style: $styles.textStyles.body,
        // Utilizar un comportamiento de desplazamiento personalizado
        // en toda la aplicación.
        child: ScrollConfiguration(
          behavior  : AppScrollBehavior(),
          child     : Scaffold(
            appBar: AppBar(
              leading : _buildLeadingButton(context),
              title   : Text(title, style: $styles.textStyles.h3),
            ),
            body: navigationShell,
            bottomNavigationBar: _buildBottomNavigationBar(),
          ),
        ),
      ),
    );
  }

  Widget? _buildLeadingButton(BuildContext context) {
    final GoRouterDelegate routerDelegate   = GoRouter.of(context).routerDelegate;
    final RouteMatchList currentConfig      = routerDelegate.currentConfiguration;

    if (currentConfig.isEmpty) return null;

    final RouteMatch lastMatch  = currentConfig.last;
    final Uri location          = lastMatch is ImperativeRouteMatch ? lastMatch.matches.uri : currentConfig.uri;
    final bool canPop           = location.pathSegments.length > 1;

    return canPop ? BackButton(onPressed: routerDelegate.pop) : null;
  }

  Widget _buildBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      destinations: const <Widget>[
        NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
        NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        NavigationDestination(icon: Icon(Icons.format_list_bulleted), label: 'Actividad'),
        NavigationDestination(icon: Badge(label: Text('+99'), child: Icon(Icons.notifications)), label: 'Notificaciones'),
      ],
      onDestinationSelected: (int index) => navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
    );
  }
}
