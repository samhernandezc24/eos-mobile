import 'package:eos_mobile/shared/shared.dart';

class InspeccionListPage extends StatefulWidget {
  const InspeccionListPage({super.key});

  @override
  State<InspeccionListPage> createState() => _InspeccionListPageState();
}

class _InspeccionListPageState extends State<InspeccionListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Inspecciones',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(),
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
}
