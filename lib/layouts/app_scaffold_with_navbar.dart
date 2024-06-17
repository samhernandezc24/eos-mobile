import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/core/di/injection_container.dart';
import 'package:eos_mobile/core/enums/inspeccion_index_menu.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/eos_mobile_logo.dart';
import 'package:eos_mobile/ui/common/modals/full_screen_web_view.dart';
import 'package:eos_mobile/ui/pages/settings/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

part './widgets/_about_dialog_content.dart';
part './widgets/_drawer_header_effect.dart';

class AppScaffoldWithNavBar extends StatefulWidget {
  const AppScaffoldWithNavBar({
    required this.title,
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('AppScaffoldWithNavBar'));

  final String title;
  final StatefulNavigationShell navigationShell;

  @override
  State<AppScaffoldWithNavBar> createState() => _AppScaffoldWithNavBarState();
}

class _AppScaffoldWithNavBarState extends State<AppScaffoldWithNavBar> {
  static AppStyles get styles => _styles;
  static AppStyles _styles = AppStyles();

  // EVENTS
  Future<void> _handleAboutAppTap(BuildContext context) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final Widget applicationIcon  = Container(
      decoration: BoxDecoration(
        border        : Border.all(color: Colors.grey),
        borderRadius  : BorderRadius.circular($styles.corners.md),
      ),
      padding: EdgeInsets.all($styles.insets.sm),
      child: const EOSMobileLogo(width: 52),
    );

    if (!mounted) return;

    showAboutDialog(
      context             : context,
      applicationIcon     : applicationIcon,
      applicationName     : $strings.defaultAppName,
      applicationVersion  : packageInfo.version,
      applicationLegalese : 'Powered by Workcube © 2024',
      children            : <Widget>[ const _AboutDialogContent() ],
    );
  }

  Future<void> _handleLogoutTap(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title   : const SizedBox.shrink(),
          content : Text('¿Salir de tu cuenta?', style: $styles.textStyles.body),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, $strings.cancelButtonText),
              child     : Text($strings.cancelButtonText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed : () => _handleLogoutRequestedPressed(context),
              child     : Text($strings.logoutButtonText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleLogoutRequestedPressed(BuildContext context) async {
    // Cierre de sesión
    await _logout();
    // Navegar a la pantalla de inicio de sesión.
    Navigator.of(context).pop();
    GoRouter.of(context).go(ScreenPaths.authSignIn);
    // Actualiza el estado de autenticación.
    settingsLogic.hasAuthenticated.value = false;
  }

  // METHODS
  Future<void> _logout() async {
    BlocProvider.of<LocalAuthBloc>(context).add(LogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    // Escucha el tamaño del dispositivo y actualiza AppStyle cuando cambia.
    final mq = MediaQuery.of(context);
    appLogic.handleAppSizeChanged(mq.size);

    // Crea un objeto de estilo que se pasa al widget tree.
    _styles = AppStyles(screenSize: context.sizePx);

    // Establece el tiempo por defecto para las animaciones de la app.
    Animate.defaultDuration = _styles.times.fast;

    // Establece la localización actual en las rutas.
    final String location = GoRouterState.of(context).uri.toString();

    return BlocProvider<LocalAuthBloc>(
      create: (_) => sl<LocalAuthBloc>()..add(GetUserInfo()),
      child: KeyedSubtree(
        key: ValueKey($styles.scale),
        child: DefaultTextStyle(
          style: $styles.textStyles.body,
          // Utilizar un comportamiento de desplazamiento personalizado en toda la aplicación.
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: Scaffold(
              appBar: AppBar(
                leading : _buildLeadingButton(context),
                title   : Text(widget.title, style: $styles.textStyles.h3),
                actions : _buildActionsButton(context, location),
              ),
              body: widget.navigationShell,
              bottomNavigationBar: _buildBottomNavigationBar(),
              drawer: _buildDrawer(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: widget.navigationShell.currentIndex,
      destinations: const <Widget>[
        NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
        NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        NavigationDestination(icon: Icon(Icons.format_list_bulleted), label: 'Actividad'),
        NavigationDestination(icon: Badge(label: Text('+99'), child: Icon(Icons.notifications)), label: 'Notificaciones'),
      ],
      onDestinationSelected: (int index) =>
          widget.navigationShell.goBranch(index, initialLocation: index == widget.navigationShell.currentIndex),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // DRAWER HEADER
          BlocBuilder<LocalAuthBloc, LocalAuthState>(
            builder: (context, state) {
              if (state is LocalAuthGetUserInfoSuccess) {
                return _buildUserAccountDrawerHeader(context, state);
              }
              return const _DrawerHeaderEffect();
            },
          ),

          // DRAWER CONTENT LIST
          // CONFIGURACION DE LA APLICACION:
          ListTile(
            leading : const Icon(Icons.settings),
            title   : Text($strings.homeMenuConfiguracionButtonText),
            onTap   : () {
              // Cerrar drawer.
              Navigator.pop(context);
              // Navegar y construir la nueva página.
              Future.delayed($styles.times.pageTransition, () {
                Navigator.push<void>(context, MaterialPageRoute<void>(builder: (_) => const SettingsPage()));
              });
            },
          ),

          // AYUDA & COMENTARIOS:
          ListTile(
            leading : const Icon(Icons.help),
            title   : Text($strings.homeMenuAyudaButtonText),
            onTap   : () {},
          ),

          // INFORMACION DE LA APLICACION:
          ListTile(
            leading : const Icon(Icons.info),
            title   : Text($strings.homeMenuInformacionButtonText),
            onTap   : () => _handleAboutAppTap(context),
          ),

          const Divider(thickness: 1),

          // CERRAR SESION:
          ListTile(
            leading   : const Icon(Icons.logout),
            title     : Text($strings.homeMenuLogoutButtonText),
            iconColor : Theme.of(context).colorScheme.error,
            textColor : Theme.of(context).colorScheme.error,
            onTap     : () => _handleLogoutTap(context),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAccountDrawerHeader(BuildContext context, LocalAuthGetUserInfoSuccess state) {
    final String accountName  = state.objResponse?.nombre     ?? '';
    final String accountEmail = state.objResponse?.user.email ?? '';

    return UserAccountsDrawerHeader(
      accountName : Text(accountName, style: $styles.textStyles.body.copyWith(color: Colors.white)),
      accountEmail : Text(accountEmail, style: $styles.textStyles.bodySmall.copyWith(color: Colors.white, height: 1.3)),
      currentAccountPicture : CircleAvatar(
        backgroundColor : Theme.of(context).colorScheme.primaryContainer,
        child : Text(
          Globals.getInitials(accountName),
          style: $styles.textStyles.h2,
        ),
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image : AssetImage(ImagePaths.background001),
          fit   : BoxFit.cover,
        ),
      ),
    );
  }

  Widget? _buildLeadingButton(BuildContext context) {
    final RouteMatchList currentConfig  = GoRouter.of(context).routerDelegate.currentConfiguration;
    final RouteMatch lastMatch          = currentConfig.last;
    final Uri location                  = lastMatch is ImperativeRouteMatch ? lastMatch.matches.uri : currentConfig.uri;
    final bool canPop                   = location.pathSegments.length > 1;

    return canPop ? BackButton(onPressed: GoRouter.of(context).pop) : null;
  }

  List<Widget>? _buildActionsButton(BuildContext context, String currentLocation) {
    switch (currentLocation) {
      case '/home/inspecciones':
        return <Widget>[
          PopupMenuButton<InspeccionIndexMenu>(
            onSelected: (InspeccionIndexMenu item) {
              if (item == InspeccionIndexMenu.configuracion) {
                GoRouter.of(context).go('/home/inspecciones/inspeccionesTipos');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<InspeccionIndexMenu>>[
              const PopupMenuItem<InspeccionIndexMenu>(
                value: InspeccionIndexMenu.configuracion,
                child: Text('Configuración de inspecciones'),
              ),
            ],
          ),
        ];
      default:
        return <Widget>[];
    }
  }
}
