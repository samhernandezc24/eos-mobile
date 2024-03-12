import 'package:eos_mobile/shared/shared.dart';

class InspeccionSearchUnidadPage extends StatefulWidget {
  const InspeccionSearchUnidadPage({Key? key}) : super(key: key);

  @override
  State<InspeccionSearchUnidadPage> createState() =>
      _InspeccionSearchUnidadPageState();
}

class _InspeccionSearchUnidadPageState
    extends State<InspeccionSearchUnidadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buscar Unidad',
          style: $styles.textStyles.h3,
        ),
      ),
      body: Container(),
    );
  }
}
