import 'dart:convert';

import 'package:eos_mobile/config/logic/common/session_manager.dart';
import 'package:eos_mobile/core/common/data/module_data.dart';
import 'package:eos_mobile/core/common/widgets/eos_mobile_logo.dart';
import 'package:eos_mobile/core/common/widgets/scaling_grid_delegate.dart';
import 'package:eos_mobile/core/di/injection_container.dart';
import 'package:eos_mobile/core/utils/string_utils.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/widgets/home/about_dialog_content.dart';
import 'package:eos_mobile/features/auth/presentation/widgets/home/drawer_header_effect.dart';
import 'package:eos_mobile/features/configuraciones/presentation/pages/index/index_page.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// LIST
  static List<ModuleData> lstModules = <ModuleData>[];

  /// PROPERTIES
  int _currentPageIndex   = 0;

  /// METHODS
  Future<void> _handleAboutPressed(BuildContext context) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (!mounted) return;
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

  Future<void> _testTokenExpiration() async {
    final SessionManager sessionManager = SessionManager();

    $logger.d('Comprobar la expiración del token ⏳...');
    await sessionManager.checkTokenExpiration();
    $logger.i('Comprobación de la expiración del token completada.');
  }

  void _handleLogoutPressed(BuildContext context) {
    if (!mounted) return;
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const SizedBox.shrink(),
          content: Text('¿Salir de tu cuenta?', style: $styles.textStyles.bodySmall.copyWith(fontSize: 16)),
          contentPadding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text($strings.homeMenuLogoutCancelButton, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.inverseSurface)),
            ),
            TextButton(
              onPressed: () {
                context.read<LocalAuthBloc>().add(LogoutRequested());
                Navigator.of(context).pop();
                context.go(ScreenPaths.authSignIn);
                settingsLogic.hasAuthenticated.value = false;
              },
              child: Text($strings.homeMenuLogoutAcceptButton, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
            ),
          ],
        );
      },
    );
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _currentPageIndex = index;
    });
    // Realizar la navegación correspondiente.
    // switch (_currentPageIndex) {
    //   case 0:
    //     GoRouter.of(context).go(ScreenPaths.home);
    //   case 1:
    //     GoRouter.of(context).go(ScreenPaths.dashboard);
    //   case 2:
    //     GoRouter.of(context).go(ScreenPaths.actividad);
    //   case 3:
    //     GoRouter.of(context).go(ScreenPaths.cuenta);
    // }
  }

  @override
  Widget build(BuildContext context) {
    // Establecer los datos para los módulos.
    lstModules = <ModuleData>[
      ModuleData($strings.homePageModule1, Icons.checklist),
      ModuleData($strings.homePageModule2, Icons.shopping_cart),
      ModuleData($strings.homePageModule3, Icons.forklift),
      ModuleData($strings.homePageModule4, Icons.assignment_turned_in),
      ModuleData($strings.homePageModule5, Icons.folder),
      ModuleData($strings.homePageModule6, Icons.local_shipping),
    ];

    return BlocProvider<LocalAuthBloc>(
      create: (_) => sl<LocalAuthBloc>()..add(GetUserInfo()),
      child: Scaffold(
        appBar: AppBar(
          title: Text($strings.defaultAppName, style: $styles.textStyles.h3),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: const Badge(child: Icon(Icons.notifications))),
            IconButton(onPressed: _testTokenExpiration, icon: const Icon(Icons.bug_report)),
          ],
        ),
        body: _buildBody(),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: _onDestinationSelected,
          selectedIndex: _currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
            NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            NavigationDestination(icon: Icon(Icons.format_list_bulleted), label: 'Actividad'),
            NavigationDestination(icon: Icon(Icons.account_circle), label: 'Cuenta'),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _buildDrawerHeader(),
              /// NAVEGACIÓN RÁPIDA DE LA APLICACIÓN:
              _buildDrawerList(
                title: 'Navegación',
                items: <Widget>[
                  _buildDrawerItem(icon: Icons.home, text: $strings.homeMenuButtonHome, onTap: (){}),
                  _buildDrawerItem(icon: Icons.dashboard, text: $strings.homeMenuButtonDashboard, onTap: (){}),
                  _buildDrawerItem(icon: Icons.format_list_bulleted, text: $strings.homeMenuButtonActivity, onTap: (){}),
                  _buildDrawerItem(icon: Icons.account_circle, text: $strings.homeMenuButtonAccount, onTap: (){}),
                  _buildDrawerItem(
                    icon: Icons.notifications,
                    text: $strings.homeMenuButtonNotification,
                    trailing: Text('+99', style: $styles.textStyles.label),
                    onTap: (){},
                  ),
                ],
              ),
              const Divider(thickness: 1),
              /// MÓDULOS DE LA APLICACIÓN:
              _buildDrawerList(
                title: 'Módulos',
                items: <Widget>[
                  _buildDrawerItem(icon: Icons.checklist, text: $strings.homeMenuButtonModule1, onTap: (){}),
                  _buildDrawerItem(icon: Icons.shopping_cart, text: $strings.homeMenuButtonModule2, onTap: (){}),
                  _buildDrawerItem(icon: Icons.forklift, text: $strings.homeMenuButtonModule3, onTap: (){}),
                  _buildDrawerItem(icon: Icons.assignment_turned_in, text: $strings.homeMenuButtonModule4, onTap: (){}),
                  _buildDrawerItem(icon: Icons.folder, text: $strings.homeMenuButtonModule5, onTap: (){}),
                  _buildDrawerItem(icon: Icons.local_shipping, text: $strings.homeMenuButtonModule6, onTap: (){}),
                ],
              ),
              /// CONFIGURACIONES, INFORMACIÓN DE LA APLICACIÓN:
              const Divider(thickness: 1),
              _buildDrawerItem(
                icon: Icons.settings,
                text: $strings.homeMenuButtonSettings,
                onTap: () {
                  Navigator.pop(context);
                  Future.delayed($styles.times.pageTransition, () {
                    Navigator.push<void>(context, MaterialPageRoute(builder: (_) => const ConfiguracionesIndexPage()));
                  });
                },
              ),
              _buildDrawerItem(icon: Icons.help, text: $strings.homeMenuButtonHelp, onTap: (){}),
              _buildDrawerItem(icon: Icons.info, text: $strings.homeMenuButtonAbout, onTap: () => _handleAboutPressed(context)),
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
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all($styles.insets.xs),
      child: GridView.builder(
        padding: EdgeInsets.all($styles.insets.xs),
        gridDelegate: ScalingGridDelegate(dimension: 180),
        itemCount: lstModules.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              switch (index) {
                case 0:
                  GoRouter.of(context).go('/home/inspecciones');

                /// se agregaran las demás rutas para los módulos
                /// una vez se haya finalizado el módulo principal.
              }
            },
            child: GridTile(
              header: GridTileBar(
                title: Text(
                  lstModules[index].name,
                  style: $styles.textStyles.bodySmall.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.all($styles.insets.xs),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular($styles.corners.md),
                  ),
                  gradient: RadialGradient(
                    colors: <Color>[
                      Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.8),
                      Theme.of(context).colorScheme.tertiaryContainer,
                    ],
                  ),
                ),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Center(
                      child: Container(
                        width: constraints.maxWidth * 0.38,
                        height: constraints.maxWidth * 0.38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                        ),
                        child: Center(
                          child: Icon(
                            lstModules[index].icon,
                            size: constraints.maxWidth * 0.28,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return BlocBuilder<LocalAuthBloc, LocalAuthState>(
      builder: (BuildContext context, LocalAuthState state) {
        if (state is LocalUserInfoSuccess) {
          if (state.userInfo != null) {
            final Map<String, dynamic> objUserData = jsonDecode(state.userInfo!['user'] ?? '{}') as Map<String, dynamic>;
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

  Widget _buildDrawerList({required List<Widget> items, required String title}) {
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

  Widget _buildDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap, Widget? trailing}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
      trailing: trailing,
    );
  }
}
