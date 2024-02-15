import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class InspeccionPage extends StatelessWidget {
  const InspeccionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspecciones de Unidades'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            GoRouter.of(context).go('/');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Center(
          child: ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                  onTap: () {},
                  leading: const FaIcon(FontAwesomeIcons.listUl),
                  title: const Text('Lista de inspecciones'),
                  trailing: const FaIcon(FontAwesomeIcons.angleRight),
                ),
                ListTile(
                  onTap: () {},
                  leading: const FaIcon(FontAwesomeIcons.folder),
                  title: const Text(
                    'Nueva inspección de unidad con requerimiento',
                  ),
                  trailing: const FaIcon(FontAwesomeIcons.angleRight),
                ),
                ListTile(
                  onTap: () {
                    GoRouter.of(context).go('/inspecciones/sin-requerimientos');
                  },
                  leading: const FaIcon(FontAwesomeIcons.listCheck),
                  title: const Text(
                    'Nueva inspección de unidad sin requerimiento',
                  ),
                  trailing: const FaIcon(FontAwesomeIcons.angleRight),
                ),
                ListTile(
                  onTap: () {},
                  leading: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                  title: const Text('Buscar unidad'),
                  trailing: const FaIcon(FontAwesomeIcons.angleRight),
                ),
              ],
            ).toList(),
          ),
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
    );
  }
}
