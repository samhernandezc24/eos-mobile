import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> moduleNames = [
    'Inspecciones',
    'Compras',
    'Embarques',
    'Requerimientos',
    'Servicios',
    'Unidades',
  ];

  final List<FaIcon> moduleIcons = [
    const FaIcon(FontAwesomeIcons.listCheck, size: 25),
    const FaIcon(FontAwesomeIcons.cartShopping, size: 25),
    const FaIcon(FontAwesomeIcons.truckFast, size: 25),
    const FaIcon(FontAwesomeIcons.fileInvoice, size: 25),
    const FaIcon(FontAwesomeIcons.database, size: 25),
    const FaIcon(FontAwesomeIcons.truck, size: 25),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EOS Mobile',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            Icon(
              Icons.notifications,
              size: 30,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          children: <Widget>[
            GridView.builder(
              itemCount: moduleNames.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    //debugPrint('/${moduleNames[index].toLowerCase()}');
                    GoRouter.of(context).go('/${moduleNames[index].toLowerCase()}');
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: moduleIcons[index]),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        moduleNames[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).hintColor.withOpacity(0.7),
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
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.dashboard),
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.format_list_bulleted),
            icon: Icon(Icons.format_list_bulleted_outlined),
            label: 'Actividad',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Cuenta',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1584999734482-0361aecad844?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=300',
                ),
              ),
              accountEmail: const Text('mauricio.santiago@heavy-lift.com.mx'),
              accountName: const Text('Mauricio Santiago'),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
