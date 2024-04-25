import 'package:eos_mobile/features/inspecciones/presentation/widgets/unidad/create_unidad_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateUnidadPage extends StatefulWidget {
  const CreateUnidadPage({Key? key}) : super(key: key);

  @override
  State<CreateUnidadPage> createState() => _CreateUnidadPageState();
}

class _CreateUnidadPageState extends State<CreateUnidadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nueva unidad', style: $styles.textStyles.h3)),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.xs),
        children: const <Widget>[
          // CAMPOS PARA CREAR LA UNIDAD TEMPORAL
          CreateUnidadForm(),
        ],
      ),
    );
  }
}
