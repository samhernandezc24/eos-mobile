import 'package:eos_mobile/shared/shared.dart';

class InspeccionUnidadConRequerimientoPage extends StatefulWidget {
  const InspeccionUnidadConRequerimientoPage({super.key});

  @override
  State<InspeccionUnidadConRequerimientoPage> createState() =>
      _InspeccionUnidadConRequerimientoPageState();
}

class _InspeccionUnidadConRequerimientoPageState
    extends State<InspeccionUnidadConRequerimientoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Unidades Con Requerimientos',
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
