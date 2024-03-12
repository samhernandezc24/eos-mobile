import 'package:eos_mobile/features/configuraciones/presentation/pages/inspecciones/inspeccion_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionIndexPage extends StatefulWidget {
  const ConfiguracionIndexPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracionIndexPage> createState() => _ConfiguracionIndexPageState();
}

class _ConfiguracionIndexPageState extends State<ConfiguracionIndexPage> {
  List<String> lstConfiguraciones = [
    'Configuración de inspecciones',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuración',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back, color: Colors.black,  ),
          onTap: () {
            Navigator.pop(context);
          } ,
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              size: 20,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem<void>(
                child: Text('Ayuda y comentarios'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.separated(
          itemCount: lstConfiguraciones.length,
          itemBuilder: (BuildContext context, int index) {
            final item = lstConfiguraciones[index];
            return ListTile(
              title: Text(item),
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const ConfiguracionInspeccionPage(),
                      ),
                    );
                }
              },
              trailing: const Icon(
                Icons.navigate_next,
                size: 18,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
    );
  }
}
