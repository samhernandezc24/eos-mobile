import 'package:eos_mobile/features/configuraciones/presentation/pages/categorias/categoria_page.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/create_inspeccion.dart';
import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionInspeccionPage extends StatefulWidget {
  const ConfiguracionInspeccionPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracionInspeccionPage> createState() =>
      _ConfiguracionInspeccionPageState();
}

class _ConfiguracionInspeccionPageState
    extends State<ConfiguracionInspeccionPage> {
  List<String> lstInspecciones = [];

  Future<void> refresh() async {
    setState(() {
      lstInspecciones.addAll(['Inspeccion 4', 'Inspeccion 5', 'Inspeccion 6']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuración de Inspecciones',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            color: Theme.of(context).highlightColor,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const CreateInspeccion();
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.plus,
                size: 16,
              ),
              label: const Text(
                'Crear inspección',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Listado de Inspecciones',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Mantener presionado la inspección para ver más opciones.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: refresh,
              child: ListView.separated(
                itemCount: lstInspecciones.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = lstInspecciones[index];
                  return ListTile(
                    title: Text(item),
                    onTap: () {},
                    leading: const FaIcon(
                      FontAwesomeIcons.layerGroup,
                      size: 20,
                    ),
                    trailing: IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.ellipsisVertical,
                        size: 18,
                      ),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const ListTile(
                                    title: Text(
                                      'Inspección: Grúas',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    leading: const FaIcon(
                                      FontAwesomeIcons.circlePlus,
                                      size: 18,
                                    ),
                                    title: const Text('Crear categoría'),
                                    onTap: () {
                                      // Abrir la nueva pagina de categorias
                                      Future.delayed(
                                          const Duration(milliseconds: 300),
                                          () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (context) =>
                                                const ConfiguracionCategoriaPage(),
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                  ListTile(
                                    leading: const FaIcon(
                                      FontAwesomeIcons.penToSquare,
                                      size: 18,
                                    ),
                                    title: const Text('Editar'),
                                    onTap: () {},
                                  ),
                                  ListTile(
                                    leading: FaIcon(
                                      FontAwesomeIcons.trash,
                                      size: 18,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                    title: Text(
                                      'Eliminar',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
