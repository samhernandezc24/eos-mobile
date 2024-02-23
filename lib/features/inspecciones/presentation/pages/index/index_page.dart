import 'package:eos_mobile/features/inspecciones/presentation/pages/list/list_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/search_unidad/search_unidad_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/unidad_con_requerimiento/unidad_con_requerimiento_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/unidad_sin_requerimiento/unidad_sin_requerimiento_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionIndexPage extends StatefulWidget {
  const InspeccionIndexPage({Key? key}) : super(key: key);

  @override
  State<InspeccionIndexPage> createState() => _InspeccionIndexPageState();
}

class _InspeccionIndexPageState extends State<InspeccionIndexPage> {
  final List<String> itemNames = <String>[
    'Lista de inspecciones',
    'Nueva inspección de unidad con requerimiento',
    'Nueva inspección de unidad sin requerimiento',
    'Buscar unidad',
  ];

  final List<FaIcon> itemIcons = <FaIcon>[
    const FaIcon(FontAwesomeIcons.listOl, size: 20),
    const FaIcon(FontAwesomeIcons.checkToSlot, size: 20),
    const FaIcon(FontAwesomeIcons.tableList, size: 20),
    const FaIcon(FontAwesomeIcons.magnifyingGlass, size: 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Índice de Inspecciones',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                itemNames[index],
              ),
              onTap: () {
                switch (index) {
                  case 0:
                    Future.delayed(const Duration(milliseconds: 300), () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InspeccionListPage(),
                        ),
                      );
                    });
                  case 1:
                    Future.delayed(const Duration(milliseconds: 300), () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const InspeccionUnidadConRequerimientoPage(),
                        ),
                      );
                    });
                  case 2:
                    Future.delayed(const Duration(milliseconds: 300), () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const InspeccionUnidadSinRequerimientoPage(),
                        ),
                      );
                    });
                  case 3:
                    Future.delayed(const Duration(milliseconds: 300), () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const InspeccionSearchUnidadPage(),
                        ),
                      );
                    });
                }
              },
              leading: itemIcons[index],
              trailing: const FaIcon(FontAwesomeIcons.angleRight, size: 18),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: itemNames.length,
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
}
