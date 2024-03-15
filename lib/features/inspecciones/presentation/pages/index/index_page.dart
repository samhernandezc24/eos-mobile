import 'package:eos_mobile/features/inspecciones/presentation/pages/unidad_sin_requerimiento/unidad_sin_requerimiento_finish_page.dart';
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

  final List<Icon> itemIcons = <Icon>[
    const Icon(Icons.format_list_numbered),
    const Icon(Icons.fact_check),
    const Icon(Icons.my_library_books),
    const Icon(Icons.search),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Índice de Inspecciones',
          style: $styles.textStyles.h3,
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
                    context.go('/home/inspecciones/list');
                  case 1:
                    context.go('/home/inspecciones/conrequerimiento');
                  case 2:
                    Navigator.push<void>(
                      context,
                      PageRouteBuilder<void>(
                        transitionDuration: $styles.times.pageTransition,
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          const Offset begin = Offset(0, 1);
                          const Offset end = Offset.zero;
                          const Cubic curve = Curves.ease;

                          final Animatable<Offset> tween =
                              Tween<Offset>(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive<Offset>(tween),
                            child: const InspeccionUnidadSinRequerimientoFinishPage(),
                          );
                        },
                      ),
                    );
                  case 3:
                    context.go('/home/inspecciones/searchunidad');
                }
              },
              leading: itemIcons[index],
              trailing: const Icon(Icons.keyboard_arrow_right, size: 24),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: itemNames.length,
        ),
      ),
    );
  }
}
