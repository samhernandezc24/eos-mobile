import 'package:eos_mobile/features/configuraciones/presentation/pages/inspecciones_tipos/inspecciones_tipos_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionesIndexPage extends StatefulWidget {
  const ConfiguracionesIndexPage({super.key});

  @override
  State<ConfiguracionesIndexPage> createState() =>
      _ConfiguracionesIndexPageState();
}

class _ConfiguracionesIndexPageState extends State<ConfiguracionesIndexPage> {
  final List<String> lstConfiguraciones = [
    'Configuración de inspecciones',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuración',
          style: $styles.textStyles.h3,
        ),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final item = lstConfiguraciones[index];
          return ListTile(
            title: Text(item),
            onTap: () {
              switch (index) {
                case 0:
                  Future.delayed($styles.times.pageTransition, () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const ConfiguracionesInspeccionesTiposPage(),
                      ),
                    );
                  });
              }
            },
            trailing: const Icon(Icons.navigate_next),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: lstConfiguraciones.length,
      ),
    );
  }
}
