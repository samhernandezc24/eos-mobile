import 'package:eos_mobile/core/common/data/modules_data.dart';
import 'package:eos_mobile/core/common/widgets/card_view.dart';
import 'package:eos_mobile/features/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = const FlutterSecureStorage();
  final prefs = SharedPreferences.getInstance();

  static List<ModulesData> modulesData = [];

  @override
  void initState() {
    super.initState();
    _checkSecureStorage();
    _checkSharedPreferences();
  }

  Future<void> _checkSecureStorage() async {
    final allValues = await storage.readAll();
    if (allValues.isEmpty) {
      print('El almacenamiento seguro está vacío.');
    } else {
      allValues.forEach((key, value) {
        print('$key: $value');
      });
    }
  }

  Future<void> _checkSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    if (keys.isEmpty) {
      print('El almacenamiento de SharedPreferences está vacío.');
    } else {
      keys.forEach((key) {
        final value = prefs.get(key);
        print('$key: $value');
      });
    }
  }

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
                _logout();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    await storage.deleteAll();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const AuthSignInPage(),
      ),
    );
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

    return Padding(
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
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       'EOS Mobile',
    //       style: $styles.textStyles.h3,
    //     ),
    //     actions: [
    //       IconButton(
    //         onPressed: () {},
    //         icon: const Icon(Icons.notifications),
    //       ),
    //     ],
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16),
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           GridView.builder(
    //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 2,
    //               mainAxisSpacing: 16,
    //               crossAxisSpacing: 16,
    //             ),
    //             itemCount: modulesData.length,
    //             shrinkWrap: true,
    //             physics: const NeverScrollableScrollPhysics(),
    //             itemBuilder: (context, index) {
    //               return CardViewIcon(
    //                 icon: modulesData[index].icon,
    //                 title: modulesData[index].name,
    //                 onTap: () {
    //                   switch (index) {
    //                     case 0:
    //                       GoRouter.of(context).go('/home/inspecciones');

    //                     /// se agregaran las demás rutas para los módulos
    //                     /// una vez se haya finalizado el módulo principal.
    //                   }
    //                 },
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   drawer: Drawer(
    //     child: ListView(
    //       padding: EdgeInsets.zero,
    //       children: <Widget>[
    //         _buildDrawerHeader(),
    //         _buildDrawerItem(
    //           icon: Icons.home,
    //           text: 'Inicio',
    //           onTap: () => {},
    //         ),
    //         _buildDrawerItem(
    //           icon: Icons.dashboard,
    //           text: 'Dashboard',
    //           onTap: () => {},
    //         ),
    //         _buildDrawerItem(
    //           icon: Icons.format_list_bulleted,
    //           text: 'Actividad',
    //           onTap: () => {},
    //         ),
    //         _buildDrawerItem(
    //           icon: Icons.account_circle,
    //           text: 'Cuenta',
    //           onTap: () => {},
    //         ),
    //         const Divider(),
    //         _buildDrawerItem(
    //           icon: Icons.settings,
    //           text: 'Configuración',
    //           onTap: () {
    //             // Cerrar el drawer
    //             Navigator.pop(context);
    //             // Actualizar el estado en la app
    //             Future.delayed(const Duration(milliseconds: 300), () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute<void>(
    //                   builder: (context) => const ConfiguracionIndexPage(),
    //                 ),
    //               );
    //             });
    //           },
    //         ),
    //         const Divider(),
    //         _buildDrawerItem(
    //           iconColor: Theme.of(context).colorScheme.error,
    //           textColor: Theme.of(context).colorScheme.error,
    //           icon: Icons.logout,
    //           text: 'Cerrar sesión',
    //           onTap: (){},
    //           // onTap: _showLogoutConfirmationDialog,
    //         ),
    //       ],
    //     ),
    //   ),
    //   bottomNavigationBar: NavigationBar(
    //     destinations: const <NavigationDestination>[
    //       NavigationDestination(
    //         icon: Icon(Icons.home),
    //         label: 'Inicio',
    //       ),
    //       NavigationDestination(
    //         icon: Icon(Icons.dashboard),
    //         label: 'Dashboard',
    //       ),
    //       NavigationDestination(
    //         icon: Icon(Icons.format_list_bulleted),
    //         label: 'Actividad',
    //       ),
    //       NavigationDestination(
    //         icon: Icon(Icons.account_circle),
    //         label: 'Cuenta',
    //       ),
    //     ],
    //     // selectedIndex: widget.navigationShell.currentIndex,
    //     // onDestinationSelected: (int index) => _onTap(context, index),
    //   ),
    // );
  }

  Widget _buildDrawerHeader() {
    return const UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
          'https://images.unsplash.com/photo-1584999734482-0361aecad844?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=300',
        ),
      ),
      accountEmail: Text(
        'mauricio.santiago@heavy-lift.com.mx',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      accountName: Text(
        'Mauricio Santiago',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(ImagePaths.background1),
        ),
      ),
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
