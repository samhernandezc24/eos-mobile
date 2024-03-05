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

  final List<Icon> itemIcons = <Icon>[
    const Icon(Icons.format_list_numbered),
    const Icon(Icons.fact_check),
    const Icon(Icons.my_library_books),
    const Icon(Icons.search),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    GoRouter.of(context).go('/home/inspecciones/list');
                  case 1:
                    GoRouter.of(context)
                        .go('/home/inspecciones/conrequerimiento');
                  case 2:
                    showGeneralDialog<void>(
                      transitionBuilder: (context, animation, secondaryAnimation, child) {
                        final double scale = Curves.easeInOut.transform(animation.value);
                        final double opacity = Curves.easeInOut.transform(animation.value);
                        return Opacity(
                          opacity: opacity,
                          child: Transform.scale(
                            scale: scale,
                            child: child,
                          ),
                        );
                      },
                      transitionDuration: $styles.times.fast,
                      context: context,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const Center(
                          child: Dialog(
                            insetPadding: EdgeInsets.zero,
                            child: InspeccionUnidadSinRequerimientoPage(),
                          ),
                        );
                      },
                    );
                  case 3:
                    GoRouter.of(context).go('/home/inspecciones/searchunidad');
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
