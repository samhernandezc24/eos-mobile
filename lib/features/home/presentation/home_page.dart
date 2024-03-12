import 'dart:convert';

import 'package:eos_mobile/config/logic/common/session_manager.dart';
import 'package:eos_mobile/config/logic/common/user_info_storage.dart';
import 'package:eos_mobile/core/common/data/modules_data.dart';
import 'package:eos_mobile/core/common/widgets/avatar_profile_name.dart';
import 'package:eos_mobile/core/common/widgets/card_view.dart';
import 'package:eos_mobile/features/configuraciones/presentation/pages/index/index_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<ModulesData> modulesData = [];

  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text(
            '¿Está seguro que desea cerrar la sesión?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> testTokenExpiration() async {
    $logger.d('Comprobando la expiracion del token');
    final sessionManager = SessionManager();
    await sessionManager.checkTokenExpiration();
    $logger.i('Comprobacion de la expiracion del token completada.');
  }

  @override
  Widget build(BuildContext context) {
    // Definiendo el color de los iconos al primario.
    final Color moduleIconColor = Theme.of(context).primaryColor;

    // Establecer los módulos de la aplicación.
    modulesData = [
      ModulesData(
        $strings.module1,
        Icon(Icons.checklist, color: moduleIconColor),
      ),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EOS Mobile',
          style: $styles.textStyles.h3,
        ),
        actions: [
          IconButton(
            onPressed: testTokenExpiration,
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildDrawerHeader(),
            _buildDrawerItem(
              icon: Icons.home,
              text: 'Inicio',
              onTap: () => {},
            ),
            _buildDrawerItem(
              icon: Icons.dashboard,
              text: 'Dashboard',
              onTap: () => {},
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
            _buildDrawerItem(
              icon: Icons.settings,
              text: 'Configuración',
              onTap: () {
                // Cerrar el drawer
                Navigator.pop(context);

                // Actualizar el estado en la app
                Future.delayed($styles.times.fast, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const ConfiguracionIndexPage(),
                    ),
                  );
                });
              },
            ),
            const Divider(),
            _buildDrawerItem(
              iconColor: Theme.of(context).colorScheme.error,
              textColor: Theme.of(context).colorScheme.error,
              icon: Icons.logout,
              text: 'Cerrar sesión',
              onTap: () {},
              // onTap: _showLogoutConfirmationDialog,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
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
        // selectedIndex: widget.navigationShell.currentIndex,
        // onDestinationSelected: (int index) => _onTap(context, index),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return FutureBuilder<Map<String, String?>>(
      future: Future<Map<String, String?>>.delayed($styles.times.slow, UserInfoStorage.getUserInfo),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, String?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Theme.of(context).colorScheme.inverseSurface.withOpacity(0.2),
                  Theme.of(context).colorScheme.inverseSurface.withOpacity(0.3),
                  Theme.of(context).colorScheme.inverseSurface.withOpacity(0.2),
                ],
                stops: const <double>[0, 0.5, 1],
              ),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Gap($styles.insets.xs),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 125,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              BorderRadius.circular($styles.insets.sm),
                        ),
                      ),
                      Gap($styles.insets.xs),
                      Container(
                        width: 225,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              BorderRadius.circular($styles.insets.sm),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const DrawerHeader(
            child: Text('Error al cargar la información del usuario'),
          );
        } else {
          final Map<String, dynamic> userObjData = jsonDecode(snapshot.data?['user'] ?? '{}') as Map<String, dynamic>;
          final String email = userObjData['email'] as String? ?? '';
          final String name = userObjData['name'] as String? ?? '';

          return UserAccountsDrawerHeader(
            currentAccountPicture: AvatarProfileName(
              backgroundColor: Theme.of(context).chipTheme.backgroundColor,
              child: Text(
                'A',
                // 'Mauricio Alejandro Santiago Gonzalez',
                style: $styles.textStyles.h2.copyWith(color: Colors.white),
              ),
            ),
            accountEmail: Text(
              email,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            accountName: Text(
              name.toProperCase(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(ImagePaths.background1),
              ),
            ),
          );
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
          Text(
            text,
            style: $styles.textStyles.bodySmall,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
