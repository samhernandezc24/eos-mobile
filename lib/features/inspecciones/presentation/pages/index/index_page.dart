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
          // ListTile(
          //   onTap: () => context.go('/home/inspecciones/sinrequerimiento'),
          //   leading: const Icon(Icons.checklist),
          //   title: Text($strings.inspectionIndexNoReqTitle),
          //   trailing: const Icon(Icons.keyboard_arrow_right),
          // ),
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
