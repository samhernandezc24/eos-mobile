import 'dart:convert';

import 'package:eos_mobile/core/common/widgets/app_scroll_behavior.dart';
import 'package:eos_mobile/core/common/widgets/eos_mobile_logo.dart';
import 'package:eos_mobile/core/di/injection_container.dart';
import 'package:eos_mobile/core/utils/string_utils.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/widgets/home/about_dialog_content.dart';
import 'package:eos_mobile/features/auth/presentation/widgets/home/drawer_header_effect.dart';
import 'package:eos_mobile/features/configuraciones/presentation/pages/index/index_page.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppScaffoldWithNavBar extends StatelessWidget {
  const AppScaffoldWithNavBar({
    required this.title,
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('AppScaffoldWithNavBar'));

  final String title;

  /// El shell de navegación y container de los branch Navigators.
  final StatefulNavigationShell navigationShell;
  static AppStyles get styles => _styles;
  static AppStyles _styles = AppStyles();

  /// METHODS
  Future<void> _handleAboutPressed(BuildContext context) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    showAboutDialog(
      context: context,
      applicationName: $strings.defaultAppName,
      applicationVersion: packageInfo.version,
      applicationLegalese: 'Powered by Workcube © 2024',
      children: <Widget>[const AboutDialogContent()],
      applicationIcon: Container(
        padding: EdgeInsets.all($styles.insets.xs),
        child: const EOSMobileLogo(width: 52),
      ),
    );
  }

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  void _onTap(BuildContext context, int index) {
    Navigator.of(context).pop();
    Future.delayed($styles.times.medium, () {
      navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
    });
  }

  void _handleLogoutPressed(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const SizedBox.shrink(),
          content: Text('¿Salir de tu cuenta?', style: $styles.textStyles.bodySmall.copyWith(fontSize: 16)),
          contentPadding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.read<LocalAuthBloc>().add(LogoutRequested());
                Navigator.of(context).pop();
                context.go(ScreenPaths.authSignIn);
                settingsLogic.hasAuthenticated.value = false;
              },
              child: Text($strings.leaveButtonText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text($strings.cancelButtonText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Escucha el tamaño del dispositivo y actualiza AppStyle cuando cambia.
    final mq = MediaQuery.of(context);
    appLogic.handleAppSizeChanged(mq.size);

    // Crear un objeto de estilo que se pasará al árbol de Widgets.
    _styles = AppStyles(screenSize: context.sizePx);

    // Establecer el tiempo por defecto para las animaciones en la aplicación.
    Animate.defaultDuration = _styles.times.fast;

    // Establecer la localizacion actual en las rutas.
    final String location = GoRouterState.of(context).uri.toString();

    return BlocProvider<LocalAuthBloc>(
      create: (_) => sl<LocalAuthBloc>()..add(GetUserInfo()),
      child: KeyedSubtree(
        key: ValueKey($styles.scale),
        child: DefaultTextStyle(
          style: $styles.textStyles.body,
          // Utilizar un comportamiento de desplazamiento personalizado
          // en toda la aplicación.
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: Scaffold(
              appBar: AppBar(
                leading: _buildLeadingButton(context),
                title: Text(title, style: $styles.textStyles.h3),
                actions: _buildActions(context, location),
              ),
              body: navigationShell,
              bottomNavigationBar: NavigationBar(
                selectedIndex: navigationShell.currentIndex,
                destinations: const <Widget>[
                  NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
                  NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
                  NavigationDestination(icon: Icon(Icons.format_list_bulleted), label: 'Actividad'),
                  NavigationDestination(icon: Badge(label: Text('+99'), child: Icon(Icons.notifications)), label: 'Notificaciones'),
                ],
                onDestinationSelected: (int index) => _onDestinationSelected(index),
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    _buildDrawerHeader(),

                    /// NAVEGACIÓN RÁPIDA DE LA APLICACIÓN:
                    _buildDrawerList(
                      context,
                      title: 'Navegación',
                      items: <Widget>[
                        _buildDrawerItem(
                          icon: Icons.home,
                          text: $strings.homeMenuButtonHome,
                          currentIndex: navigationShell.currentIndex,
                          itemIndex: 0,
                          onTap: () => _onTap(context, 0),
                        ),
                        _buildDrawerItem(
                          icon: Icons.dashboard,
                          text: $strings.homeMenuButtonDashboard,
                          currentIndex: navigationShell.currentIndex,
                          itemIndex: 1,
                          onTap: () => _onTap(context, 1),
                        ),
                        _buildDrawerItem(
                          icon: Icons.format_list_bulleted,
                          text: $strings.homeMenuButtonActivity,
                          currentIndex: navigationShell.currentIndex,
                          itemIndex: 2,
                          onTap: () => _onTap(context, 2),
                        ),
                        _buildDrawerItem(
                          icon: Icons.notifications,
                          text: $strings.homeMenuButtonNotification,
                          currentIndex: navigationShell.currentIndex,
                          itemIndex: 3,
                          trailing: Text('+99', style: $styles.textStyles.label),
                          onTap: () => _onTap(context, 3),
                        ),
                      ],
                    ),

                    const Divider(thickness: 1),

                    /// CONFIGURACIONES, INFORMACIÓN DE LA APLICACIÓN:
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: Text($strings.homeMenuButtonSettings),
                      onTap: () {
                        Navigator.pop(context);
                        Future.delayed($styles.times.pageTransition, () {
                          Navigator.push<void>(context, MaterialPageRoute(builder: (_) => const ConfiguracionesIndexPage()));
                        });
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.help),
                      title: Text($strings.homeMenuButtonHelp),
                      onTap: () {},
                    ),

                    ListTile(
                      leading: const Icon(Icons.info),
                      title: Text($strings.homeMenuButtonAbout),
                      onTap: () => _handleAboutPressed(context),
                    ),

                    const Divider(thickness: 1),

                    /// CERRAR SESIÓN:
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.error,
                      textColor: Theme.of(context).colorScheme.error,
                      leading: const Icon(Icons.logout),
                      title: Text($strings.homeMenuButtonLogout),
                      onTap: () => _handleLogoutPressed(context),
                    ),
                  ],
                ),
              ),
              resizeToAvoidBottomInset: false,
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildLeadingButton(BuildContext context) {
    final RouteMatchList currentConfiguration = GoRouter.of(context).routerDelegate.currentConfiguration;
    final RouteMatch lastMatch = currentConfiguration.last;
    final Uri location = lastMatch is ImperativeRouteMatch ? lastMatch.matches.uri : currentConfiguration.uri;
    final bool canPop = location.pathSegments.length > 1;
    return canPop ? BackButton(onPressed: GoRouter.of(context).pop) : null;
  }

  List<Widget>? _buildActions(BuildContext context, String currentRoute) {
    switch (currentRoute) {
      case '/home':
        return [
          IconButton(onPressed: () => authTokenHelper.testExpirationToken(), icon: const Icon(Icons.bug_report)),
        ];
      case '/home/inspecciones':
        return [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: 'configuracion', child: Text('Configuración de inspecciones')),
            ],
            onSelected: (String value) {
              if (value == 'configuracion') {
                GoRouter.of(context).go('/home/inspecciones/inspeccionTipo');
              }
            },
          ),
        ];
      default:
        return [];
    }
  }

  Widget _buildDrawerHeader() {
    return BlocBuilder<LocalAuthBloc, LocalAuthState>(
      builder: (BuildContext context, LocalAuthState state) {
        if (state is LocalUserInfoSuccess) {
          if (state.userInfo != null) {
            final Map<String, dynamic> objUserData =
                jsonDecode(state.userInfo!['user'] ?? '{}')
                    as Map<String, dynamic>;
            final String? accountName = state.userInfo!['nombre'];
            final String? accountEmail = objUserData['email'] as String?;
            return _buildUserAccountDrawerHeader(context, accountName, accountEmail);
          } else {
            return _buildDefaultDrawerHeader(context);
          }
        } else {
          // Retornamos el `DrawerHeaderEffect` si no se puede cargar la información correctamente.
          return const DrawerHeaderEffect();
        }
      },
    );
  }

  Widget _buildUserAccountDrawerHeader(BuildContext context, String? accountName, String? accountEmail) {
    return UserAccountsDrawerHeader(
      accountName: Text(accountName ?? '', style: const TextStyle(color: Colors.white)),
      accountEmail: Text(accountEmail ?? '', style: const TextStyle(color: Colors.white)),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Theme.of(context).chipTheme.backgroundColor,
        child: Text(StringUtils.getInitials(accountName ?? ''), style: $styles.textStyles.h2),
      ),
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(ImagePaths.drawerHeaderBackground), fit: BoxFit.cover)),
    );
  }

  Widget _buildDefaultDrawerHeader(BuildContext context) {
    return const UserAccountsDrawerHeader(
      accountName: Text('John Doe'),
      accountEmail: Text('john@doe.com'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1584999734482-0361aecad844?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=300'),
      ),
    );
  }

  Widget _buildDrawerList(BuildContext context, {required List<Widget> items, required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: $styles.insets.sm, top: $styles.insets.xs),
          child: Text(title, style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.inverseSurface)),
        ),
        ...items,
      ],
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
    Widget? trailing,
    int? itemIndex,
    int? currentIndex,
  }) {
    final bool isSelected = currentIndex == itemIndex;

    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      selected: isSelected,
      onTap: onTap,
      trailing: trailing,
    );
  }
}
