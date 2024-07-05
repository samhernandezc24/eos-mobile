import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/inspeccion_tipo/inspeccion_tipo_page.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class InspeccionIndexPage extends StatefulWidget {
  const InspeccionIndexPage({Key? key}) : super(key: key);

  @override
  State<InspeccionIndexPage> createState() => _InspeccionIndexPageState();
}

class _InspeccionIndexPageState extends State<InspeccionIndexPage> {
  // EVENTS
  void _handleSelectMenuItem(int item) {
    switch (item) {
      case 0:
        Navigator.push<void>(
          context,
          MaterialPageRoute(builder: (context) => const InspeccionConfiguracionInspeccionTipoPage()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = Container();
    return Scaffold(
      appBar: AppBar(
        title   : Text(AppStrings.inspeccionIndexAppBarTitle, style: $styles.textStyles.h3),
        actions : <Widget>[
          PopupMenuButton<int>(
            onSelected  : (int item) => _handleSelectMenuItem(item),
            itemBuilder : (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(value: 0, child: Text('Configuración de inspecciones')),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: ColoredBox(color: Theme.of(context).colorScheme.background.withOpacity(0.4), child: content)),
        ],
      ),
    );
  }
}
