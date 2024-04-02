import 'dart:convert';

import 'package:eos_mobile/config/logic/common/session_manager.dart';
import 'package:eos_mobile/core/common/data/modules_data.dart';
import 'package:eos_mobile/core/common/widgets/card_view.dart';
import 'package:eos_mobile/core/di/injection_container.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/widgets/home/custom_drawer_header.dart';
import 'package:eos_mobile/shared/shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<ModulesData> modulesData = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocalAuthBloc>(context).add(GetUserSession());
  }
  Future<void> testTokenExpiration() async {
    $logger.d('Comprobando la expiracion del token');
    final sessionManager = SessionManager();
    await sessionManager.checkTokenExpiration();
    await sessionManager.renewFakeToken();
    $logger.i('Comprobacion de la expiracion del token completada.');
  }

  String _getInitials(String fullName) {
    final List<String> nameParts = fullName.split(' ');
    final StringBuffer initialsBuffer = StringBuffer();

    int initialsCount = 0;

    for (final part in nameParts) {
      if (initialsCount < 2) {
        initialsBuffer.write(part[0]);
        initialsCount++;
      }
    }

    return initialsBuffer.toString().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    // Definiendo el color de los iconos al primario.
    final Color moduleIconColor = Theme.of(context).primaryColor;

    int currentPageIndex = 0;

    // Establecer los módulos de la aplicación.
    modulesData = [
      ModulesData(
          $strings.module1, Icon(Icons.checklist, color: moduleIconColor)),
      ModulesData(
        $strings.module2,
        Icon(Icons.shopping_cart, color: moduleIconColor),
      ),
      ModulesData(
        $strings.module3,
        Icon(Icons.forklift, color: moduleIconColor),
      ),
      ModulesData(
        $strings.module4,
        Icon(Icons.assignment_turned_in, color: moduleIconColor),
      ),
      ModulesData(
        $strings.module5,
        Icon(Icons.folder, color: moduleIconColor),
      ),
      ModulesData(
        $strings.module6,
        Icon(Icons.local_shipping, color: moduleIconColor),
      ),
    ];

    return BlocProvider(
      create: (_) => sl<LocalAuthBloc>()..add(GetUserInfo()),
      child: Scaffold(
        appBar: AppBar(
          title: Text($strings.defaultAppName, style: $styles.textStyles.h3),
          actions: [
            IconButton(onPressed: testTokenExpiration, icon: const Icon(Icons.notifications)),
          ],
        ),
        body: _buildBody(),
        bottomNavigationBar: NavigationBar(
          destinations: const <NavigationDestination>[
            NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
            NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            NavigationDestination(icon: Icon(Icons.format_list_bulleted), label: 'Actividad'),
            NavigationDestination(icon: Icon(Icons.account_circle), label: 'Cuenta'),
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
            _navigateToPage(index);
          },
          selectedIndex: currentPageIndex,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _buildDrawerHeader(context),
              _buildDrawerItem(
                icon: Icons.home,
                text: 'Inicio',
                onTap: () => context.go('/home'),
              ),
              _buildDrawerItem(
                icon: Icons.dashboard,
                text: 'Dashboard',
                onTap: () => context.go('/dashboard'),
              ),
              _buildDrawerItem(
                icon: Icons.format_list_bulleted,
                text: 'Actividad',
                onTap: () => {},
              ),
              _buildDrawerItem(
                icon: Icons.account_circle,
                text: 'Cuenta',
                onTap: () => {},
              ),
              const Divider(),
              // _buildDrawerItem(
              //   icon: Icons.settings,
              //   text: 'Configuración',
              //   onTap: () {
              //     // Cerrar el drawer
              //     Navigator.pop(context);

              //     // Actualizar el estado en la app
              //     Future.delayed(.times.pageTransition, () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute<void>(
              //           builder: (context) => const ConfiguracionesIndexPage(),
              //         ),
              //       );
              //     });
              //   },
              // ),
              const Divider(),
              _buildDrawerItem(
                iconColor: Theme.of(context).colorScheme.error,
                textColor: Theme.of(context).colorScheme.error,
                icon: Icons.logout,
                text: 'Cerrar sesión',
                onTap: _showLogoutConfirmationDialog,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all($styles.insets.sm),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: modulesData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CardViewIcon(
                  icon: modulesData[index].icon,
                  title: modulesData[index].name,
                  onTap: () {
                    switch (index) {
                      case 0:
                        GoRouter.of(context).go('/home/inspecciones');

                      /// se agregaran las demás rutas para los módulos
                      /// una vez se haya finalizado el módulo principal.
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(int index) {
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

  Widget _buildDrawerHeader(BuildContext context) {
    return BlocBuilder<LocalAuthBloc, LocalAuthState>(
      builder: (BuildContext context, LocalAuthState state) {
        if (state is LocalUserInfoSuccess) {
          if (state.userInfo != null) {
            final Map<String, dynamic> objUserData = jsonDecode(state.userInfo!['user'] ?? '{}') as Map<String, dynamic>;
            final String? name = state.userInfo!['nombre'];
            final String? email = objUserData['email'] as String?;

            return UserAccountsDrawerHeader(
              accountName: Text(name ?? '', style: const TextStyle(color: Colors.white)),
              accountEmail: Text(email ?? '', style: const TextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).chipTheme.backgroundColor,
                child: Text(
                  _getInitials(name ?? ''),
                  style: $styles.textStyles.h2.copyWith(color: Colors.white),
                ),
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePaths.background1),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return const UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: Text('john@doe.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1584999734482-0361aecad844?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=300',
                ),
              ),
            );
          }
        } else {
          // Retornamos el `CustomDrawerHeader` si no se puede cargar la información correctamente.
          return const CustomDrawerHeader();
        }
      },
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      iconColor: iconColor,
      textColor: textColor,
      title: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(width: $styles.insets.sm),
          Text(text, style: $styles.textStyles.bodySmall),
        ],
      ),
      onTap: onTap,
    );
  }

  void _showLogoutConfirmationDialog() {
    Future.delayed($styles.times.fast, () {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const SizedBox.shrink(),
            content: Text('¿Salir de tu cuenta?', style: $styles.textStyles.body.copyWith(height: 1.5)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancelar', style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.inverseSurface)),
              ),
              TextButton(
                onPressed: () {
                  context.read<LocalAuthBloc>().add(LogoutRequested());
                  Navigator.of(context).pop();
                  context.go(ScreenPaths.authSignIn);
                  settingsLogic.hasAuthenticated.value = false;
                },
                child: Text('Salir', style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
              ),
            ],
          );
        },
      );
    });
  }
}
