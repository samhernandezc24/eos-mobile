import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionCategoriaPage extends StatefulWidget {
  const ConfiguracionCategoriaPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracionCategoriaPage> createState() =>
      _ConfiguracionCategoriaPageState();
}

class _ConfiguracionCategoriaPageState
    extends State<ConfiguracionCategoriaPage> {
  List<String> lstInspecciones = [
    'Categoría 1',
    'Categoría 2',
    'Categoría 3',
  ];

  Future<void> refresh() async {
    setState(() {
      lstInspecciones.addAll(['Categoría 4', 'Categoría 5', 'Categoría 6']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuración de Categorías',
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
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Nueva Categoría',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      content: Form(
                        child: Container(
                          padding: EdgeInsets.zero,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('Nombre *'),
                              const Gap(6),
                              TextFormField(
                                decoration: const InputDecoration(
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context, 'Guardar');
                          },
                          child: const Text('Guardar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, 'Cerrar');
                          },
                          child: const Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.plus,
                size: 16,
              ),
              label: const Text(
                'Crear categoría',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
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
                    onLongPress: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const ListTile(
                                  title: Text(
                                    'Categoría: Tanque de Combustible',
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
                                  title: const Text('Crear preguntas'),
                                  onTap: () {},
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
                                    color: Theme.of(context).colorScheme.error,
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
                    leading: const FaIcon(
                      FontAwesomeIcons.layerGroup,
                      size: 20,
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: 18,
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
