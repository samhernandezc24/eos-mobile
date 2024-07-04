import 'package:eos_mobile/features/auth/presentation/cubits/local/local_auth_cubit.dart';
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
            drawer: Drawer(child: _AppScaffoldWithNavBarDrawer(navigationShell: navigationShell)),
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

class _AppScaffoldWithNavBarDrawer extends StatefulWidget {
  const _AppScaffoldWithNavBarDrawer({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<_AppScaffoldWithNavBarDrawer> createState() => _AppScaffoldWithNavBarDrawerState();
}

class _AppScaffoldWithNavBarDrawerState extends State<_AppScaffoldWithNavBarDrawer> {
  @override
  void initState() {
    super.initState();
    context.read<LocalAuthCubit>().onGetUserInfo();
  }

  // EVENTS
  void _onTap(BuildContext context, int index) {
    Navigator.of(context).pop();
    Future.delayed($styles.times.medium, () {
      widget.navigationShell.goBranch(index, initialLocation: index == widget.navigationShell.currentIndex);
    });
  }

  Future<void> _handleLogoutTap(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const SizedBox.shrink(),
          content: Text(AppStrings.logoutAlertDialogTitle, style: $styles.textStyles.body),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, AppStrings.btnCancelText),
              child     : Text(AppStrings.btnCancelText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed : () => _handleLogoutPressed(context),
              child     : Text(AppStrings.btnLeaveText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleLogoutPressed(BuildContext context) async {
    // CERRAR SESION
    await _logout();

    // CERRAR ALERT DIALOG & NAVEGAR AL INICIO DE SESION
    Navigator.of(context).pop();
    GoRouter.of(context).go(AppRoutes.authSignIn);

    // ACTUALIZAMOS EL ESTADO DE AUTENTICACION
    settingsLogic.hasAuthenticated.value = false;

    // MOSTRAR FEEDBACK AL USUARIO
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(AppStrings.logoutRedirectTitle, style: $styles.textStyles.bodyBold),
            Text(AppStrings.logoutRedirectMessage, style: $styles.textStyles.body.copyWith(height: 1.3), softWrap: true),
          ],
        ),
        backgroundColor: $styles.colors.success,
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        showCloseIcon: true,
      ),
    );
  }

  // METHODS
  Future<void> _logout() async {
    return BlocProvider.of<LocalAuthCubit>(context).onLogout();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: <Widget>[
        // DRAWER HEADER
        BlocBuilder<LocalAuthCubit, LocalAuthState>(
          builder: (BuildContext context, LocalAuthState state) {
            String accountName  = '';
            String accountEmail = '';

            if (state is LocalAuthGetUserInfo) {
              accountName   = state.objResponse?.nombre     ?? '';
              accountEmail  = state.objResponse?.user.email ?? '';
            }

            return  UserAccountsDrawerHeader(
              accountName: Text(accountName, style: $styles.textStyles.body.copyWith(color: $styles.colors.white)),
              accountEmail: Text(accountEmail, style: $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white, height: 1.3)),
              currentAccountPicture: CircleAvatar(child: Text(Globals.getInitials(accountName), style: $styles.textStyles.h2)),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image         : AssetImage(ImagePaths.background001),
                  fit           : BoxFit.cover,
                  filterQuality : FilterQuality.high,
                ),
              ),
            );
          },
        ),

        // NAVIGATION
        _buildDrawerItemList(
          context,
          title : 'Navegación',
          items : <Widget>[
            _buildDrawerItem(
              icon          : Icons.home,
              text          : AppStrings.appDrawerItemHome,
              currentIndex  : widget.navigationShell.currentIndex,
              index         : 0,
              onTap         : () => _onTap(context, 0),
            ),
            _buildDrawerItem(
              icon          : Icons.dashboard,
              text          : AppStrings.appDrawerItemDashboard,
              currentIndex  : widget.navigationShell.currentIndex,
              index         : 1,
              onTap         : () => _onTap(context, 1),
            ),
            _buildDrawerItem(
              icon          : Icons.format_list_bulleted,
              text          : AppStrings.appDrawerItemActivity,
              currentIndex  : widget.navigationShell.currentIndex,
              index         : 2,
              onTap         : () => _onTap(context, 2),
            ),
            _buildDrawerItem(
              icon          : Icons.notifications,
              text          : AppStrings.appDrawerItemNotification,
              trailing      : Text('+99', style: $styles.textStyles.label),
              currentIndex  : widget.navigationShell.currentIndex,
              index         : 3,
              onTap         : () => _onTap(context, 3),
            ),
          ],
        ),

        const Divider(thickness: 1),

        // HELP
        ListTile(
          leading : const Icon(Icons.help),
          title   : const Text(AppStrings.appDrawerItemHelp),
          onTap   : (){},
        ),

        // ABOUT APP
        ListTile(
          leading : const Icon(Icons.info),
          title   : const Text(AppStrings.appDrawerItemAbout),
          onTap   : (){},
        ),

        const Divider(thickness: 1),

        // LOGOUT
        ListTile(
          leading   : const Icon(Icons.logout),
          title     : const Text(AppStrings.appDrawerItemLogout),
          iconColor : Theme.of(context).colorScheme.error,
          textColor : Theme.of(context).colorScheme.error,
          onTap     : () => _handleLogoutTap(context),
        ),
      ],
    );
  }

  Widget _buildDrawerItemList(BuildContext context, {required List<Widget> items, required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildDrawerItemTitle(context, title),
        Gap($styles.insets.xxs),
        ...items,
      ],
    );
  }

  Widget _buildDrawerItemTitle(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: 0),
      child: TopLeft(
        child: DefaultTextStyle(
          style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface),
          child: Text(
            title,
            overflow            : TextOverflow.ellipsis,
            textHeightBehavior  : const TextHeightBehavior(applyHeightToFirstAscent: false),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
    Widget? trailing,
    int? index,
    int? currentIndex,
  }) {
    final bool isSelected = currentIndex == index;
    return ListTile(
      leading   : Icon(icon),
      title     : Text(text),
      selected  : isSelected,
      onTap     : onTap,
      trailing  : trailing,
    );
  }
}
