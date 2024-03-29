import 'package:eos_mobile/shared/shared.dart';

class InspeccionUnidadConRequerimientoPage extends StatefulWidget {
  const InspeccionUnidadConRequerimientoPage({super.key});

  @override
  State<InspeccionUnidadConRequerimientoPage> createState() =>
      _InspeccionUnidadConRequerimientoPageState();
}

class _InspeccionUnidadConRequerimientoPageState
    extends State<InspeccionUnidadConRequerimientoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Unidades con Requerimientos',
          style: $styles.textStyles.h3,
        ),
      ),
      body: Container(),
    );
  }
}
