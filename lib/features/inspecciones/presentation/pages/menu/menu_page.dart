import 'package:eos_mobile/shared/shared_libs.dart';

class InspeccionMenuPage extends StatelessWidget {
  const InspeccionMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          // INDEX (LISTA DE INSPECCIONES)
          ListTile(
            leading   : const Icon(Icons.car_repair),
            title     : const Text(AppStrings.inspeccionMenuIndexPageTitle),
            subtitle  : const Text(AppStrings.inspeccionMenuIndexPageSubtitle),
            trailing  : const Icon(Icons.keyboard_arrow_right),
            onTap     : () => context.go('/home/inspecciones/index'),
          ),

          // SEARCH UNIDAD (LISTA DE UNIDADES)
          ListTile(
            leading   : const Icon(Icons.car_crash),
            title     : const Text(AppStrings.inspeccionMenuUnidadPageTitle),
            subtitle  : const Text(AppStrings.inspeccionMenuUnidadPageSubtitle),
            trailing  : const Icon(Icons.keyboard_arrow_right),
            onTap     : () => context.go('/home/inspecciones/search-unidad'),
          ),
        ],
      ),
    );
  }
}
