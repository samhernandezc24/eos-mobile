import 'package:eos_mobile/config/themes/app_theme.dart';
import 'package:eos_mobile/core/common/widgets/app_scroll_behavior.dart';
import 'package:eos_mobile/shared/shared.dart';

class AppScaffoldWithNavBar extends StatefulWidget {
  const AppScaffoldWithNavBar({
    required this.navigationShell,
    required this.title,
    Key? key,
  }) : super(key: key);

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  /// The title to display in the AppBar.
  final String title;

  static AppStyles get style => _style;
  static final AppStyles _style = AppStyles();

  @override
  State<AppScaffoldWithNavBar> createState() => _AppScaffoldWithNavBarState();
}

class _AppScaffoldWithNavBarState extends State<AppScaffoldWithNavBar> {
  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  Widget? _buildLeadingButton(BuildContext context) {
    final RouteMatchList currentConfiguration =
        GoRouter.of(context).routerDelegate.currentConfiguration;
    final RouteMatch lastMatch = currentConfiguration.last;
    final Uri location = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches.uri
        : currentConfiguration.uri;
    final bool canPop = location.pathSegments.length > 1;
    return canPop ? BackButton(onPressed: GoRouter.of(context).pop) : null;
  }

  @override
  Widget build(BuildContext context) {
    final bool isHomePage = GoRouterState.of(context).topRoute?.name == 'home';
    final theme = Theme.of(context);
    final appTheme = theme.brightness == Brightness.light
        ? AppTheme.lightTheme($styles)
        : AppTheme.darkTheme($styles);

    return KeyedSubtree(
      key: ValueKey($styles.scale),
      child: Theme(
        data: appTheme,
        child: DefaultTextStyle(
          style: $styles.textStyles.body,
          // Utilizar un comportamiento de desplazamiento personalizado
          // en toda la aplicación.
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: Scaffold(
              key: ValueKey($styles.scale),
              appBar: !isHomePage
                  ? AppBar(
                      title: Text(
                        widget.title,
                        style: $styles.textStyles.h3,
                      ),
                      leading: _buildLeadingButton(context),
                    )
                  : null,
              body: widget.navigationShell,
              bottomNavigationBar: !isHomePage ? NavigationBar(
                destinations: const <NavigationDestination>[
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: 'Inicio',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.dashboard),
                    label: 'Dashboard',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.format_list_bulleted),
                    label: 'Actividad',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.account_circle),
                    label: 'Cuenta',
                  ),
                ],
                selectedIndex: widget.navigationShell.currentIndex,
                onDestinationSelected: (int index) => _onTap(context, index),
              ) : null,
            ),
          ),
        ),
      ),
    );
  }
}
