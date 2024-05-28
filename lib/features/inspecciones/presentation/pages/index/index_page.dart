import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionIndexPage extends StatefulWidget {
  const InspeccionIndexPage({Key? key}) : super(key: key);

  @override
  State<InspeccionIndexPage> createState() => _InspeccionIndexPageState();
}

class _InspeccionIndexPageState extends State<InspeccionIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap     : () => context.go('/home/inspecciones/list'),
            leading   : const Icon(Icons.format_list_numbered),
            title     : Text($strings.inspeccionIndexListTileTitle),
            subtitle  : Text($strings.inspeccionIndexListTileSubtitle),
            trailing  : const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap     : () => context.go('/home/inspecciones/searchunidad'),
            leading   : const Icon(Icons.search),
            title     : Text($strings.inspectionIndexSearchTitle),
            subtitle  : Text($strings.inspectionIndexSearchSubtitle),
            trailing  : const Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}
