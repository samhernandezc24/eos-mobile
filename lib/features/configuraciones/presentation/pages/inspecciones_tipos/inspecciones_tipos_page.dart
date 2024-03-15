import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/create_inspeccion_tipo_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionesInspeccionesTiposPage extends StatefulWidget {
  const ConfiguracionesInspeccionesTiposPage({super.key});

  @override
  State<ConfiguracionesInspeccionesTiposPage> createState() =>
      _ConfiguracionesInspeccionesTiposPageState();
}

class _ConfiguracionesInspeccionesTiposPageState
    extends State<ConfiguracionesInspeccionesTiposPage> {
  final List<String> _inspeccionesTipos = [];

  @override
  void initState() {
    super.initState();
    _generateFakeInspeccionesTipos();
  }

  void _generateFakeInspeccionesTipos() {
    for (int i = 0; i < 20; i++) {
      _inspeccionesTipos.add('Inspeccion Tipo $i');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuración de Inspecciones',
          style: $styles.textStyles.h3,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.background,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const BasicModal(
                        title: 'Nuevo Tipo de Inspección',
                        child: CreateInspeccionTipoForm(),
                      );
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(
                'Crear Tipo Inspección',
                style: $styles.textStyles.button,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all($styles.insets.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Listado de Tipos de Inspecciones',
                  style: $styles.textStyles.title1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Gap($styles.insets.xxs),
                Text(
                  'Crear un tipo de inspección para agrupar los formularios de las inspecciones.',
                  style: $styles.textStyles.bodySmall.copyWith(height: 1.5),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                return Future<void>.delayed($styles.times.slow);
              },
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        ImagePaths.circleVehicle,
                      ),
                    ),
                    title: Text(
                      _inspeccionesTipos[index],
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: const Text('Folio: INST-24-000001'),
                    onTap: () {},
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
                              height: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Folio: INST-24-000001',
                                    textAlign: TextAlign.center,
                                    style: $styles.textStyles.h3,
                                  ),
                                  Gap($styles.insets.sm),
                                  ListTile(
                                    leading: const Icon(Icons.add),
                                    title: const Text('Crear categoría'),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Editar'),
                                    onTap: (){},
                                  ),
                                   ListTile(
                                    textColor: Theme.of(context).colorScheme.error,
                                    iconColor: Theme.of(context).colorScheme.error,
                                    leading: const Icon(Icons.delete),
                                    title: const Text('Eliminar'),
                                    onTap: (){},
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
                itemCount: _inspeccionesTipos.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
