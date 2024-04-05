import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/inspecciones_tipos/inspecciones_tipos_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/unidad_sin_requerimiento/unidad_sin_requerimiento_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionIndexPage extends StatefulWidget {
  const InspeccionIndexPage({Key? key}) : super(key: key);

  @override
  State<InspeccionIndexPage> createState() => _InspeccionIndexPageState();
}

class _InspeccionIndexPageState extends State<InspeccionIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Índice de Inspecciones',
          style: $styles.textStyles.h3,
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: 'configuracion', child: Text('Configuración de inspecciones')),
            ],
            onSelected: (String value) {
              if (value == 'configuracion') {
                Future.delayed($styles.times.pageTransition, () {
                  Navigator.push<void>(context, MaterialPageRoute(builder: (_) => const InspeccionConfiguracionInspeccionesTiposPage()));
                });
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () => context.go('/home/inspecciones/list'),
            leading: const Icon(Icons.format_list_numbered),
            title: Text($strings.inspectionIndexListTitle),
            subtitle: Text($strings.inspectionIndexListSubtitle),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () => context.go('/home/inspecciones/conrequerimiento'),
            leading: const Icon(Icons.library_add_check),
            title: Text($strings.inspectionIndexWithReqTitle),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {
              Navigator.push<void>(
                context,
                PageRouteBuilder<void>(
                  transitionDuration: $styles.times.pageTransition,
                  pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                    const Offset begin  = Offset(0, 1);
                    const Offset end    = Offset.zero;
                    const Cubic curve   = Curves.ease;

                    final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

                    return SlideTransition(position: animation.drive<Offset>(tween), child: const InspeccionUnidadSinRequerimientoPage());
                  },
                  fullscreenDialog: true,
                ),
              );
            },
            leading: const Icon(Icons.checklist),
            title: Text($strings.inspectionIndexNoReqTitle),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () => context.go('/home/inspecciones/searchunidad'),
            leading: const Icon(Icons.search),
            title: Text($strings.inspectionIndexSearchTitle),
            subtitle: Text($strings.inspectionIndexSearchSubtitle),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}
