import 'package:eos_mobile/shared/shared.dart';

class InspeccionUnidadSinRequerimientoPage extends StatefulWidget {
  const InspeccionUnidadSinRequerimientoPage({Key? key}) : super(key: key);

  @override
  State<InspeccionUnidadSinRequerimientoPage> createState() =>  _InspeccionSinRequerimientoPageState();
}

class _InspeccionSinRequerimientoPageState extends State<InspeccionUnidadSinRequerimientoPage> {
  // Definir controladores para los campos de texto
  final TextEditingController _fechaInspeccionController = TextEditingController();

  // Propiedades
  final List<String> lstOptions = <String>['Uno', 'Dos', 'Tres'];

  @override
  void dispose() {
    _fechaInspeccionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Inspección de Unidad Sin Req.',
          style: $styles.textStyles.h3,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField<String>(
              items: lstOptions.map((String option) {
                return DropdownMenuItem(
                  value: option,
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.star),
                      SizedBox(width: $styles.insets.sm),
                      Text(option)
                    ],
                  ),
                );
              }).toList(),
              onChanged: (_){},
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: $styles.insets.sm - 3, horizontal: $styles.insets.xs + 2),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Ej. Unidad',
                labelText: 'Seleccione una unidad',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
