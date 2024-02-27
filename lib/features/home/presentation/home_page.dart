import 'package:eos_mobile/features/configuraciones/presentation/pages/index/index_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/index/index_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = const FlutterSecureStorage();
  final prefs = SharedPreferences.getInstance();

  final List<String> moduleNames = [
    'Inspecciones',
    'Compras',
    'Embarques',
    'Requerimientos',
    'Proyectos',
    'Unidades',
  ];

  final List<FaIcon> moduleIcons = [
    const FaIcon(FontAwesomeIcons.listCheck, size: 24),
    const FaIcon(FontAwesomeIcons.cartShopping, size: 24),
    const FaIcon(FontAwesomeIcons.truckFast, size: 24),
    const FaIcon(FontAwesomeIcons.checkToSlot, size: 24),
    const FaIcon(FontAwesomeIcons.folder, size: 24),
    const FaIcon(FontAwesomeIcons.truck, size: 24),
  ];

  @override
  void initState() {
    super.initState();
    _checkSecureStorage();
    _checkSharedPreferences();
  }

  Future<void> _checkSecureStorage() async {
    final allValues = await storage.readAll();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
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
              onPressed: _logout,
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
    // await Navigator.pushReplacementNamed(context, '/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'EOS Mobile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            FaIcon(
              FontAwesomeIcons.bell,
              size: 20,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: moduleNames.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Future.delayed(const Duration(milliseconds: 300), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) =>
                                    const InspeccionIndexPage(),
                              ),
                            );
                          });
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: moduleIcons[index],
                          ),
                        ),
                        const Gap(10),
                        Text(
                          moduleNames[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
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
              icon: FontAwesomeIcons.house,
              text: 'Inicio',
              onTap: () => {},
            ),
            _buildDrawerItem(
              icon: FontAwesomeIcons.tableColumns,
              text: 'Dashboard',
              onTap: () => {},
            ),
            _buildDrawerItem(
              icon: FontAwesomeIcons.list,
              text: 'Actividad',
              onTap: () => {},
            ),
            _buildDrawerItem(
              icon: FontAwesomeIcons.circleUser,
              text: 'Cuenta',
              onTap: () => {},
            ),
            const Divider(),
            _buildDrawerItem(
              icon: FontAwesomeIcons.gear,
              text: 'Configuración',
              onTap: () {
                // Cerrar el drawer
                Navigator.pop(context);
                // Actualizar el estado en la app
                Future.delayed(const Duration(milliseconds: 300), () {
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
              icon: FontAwesomeIcons.rightFromBracket,
              text: 'Cerrar sesión',
              onTap: _showLogoutConfirmationDialog,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
              size: 20,
            ),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.tableColumns,
              size: 20,
            ),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.list,
              size: 20,
            ),
            label: 'Actividad',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.circleUser,
              size: 20,
            ),
            label: 'Cuenta',
          ),
        ],
      ),
    );
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
  }) {
    return ListTile(
      title: Row(
        children: <Widget>[
          FaIcon(
            icon,
            size: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
