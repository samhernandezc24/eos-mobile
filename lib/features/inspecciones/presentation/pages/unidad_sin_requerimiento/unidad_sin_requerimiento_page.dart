import 'package:eos_mobile/shared/shared.dart';

class InspeccionUnidadSinRequerimientoPage extends StatefulWidget {
  const InspeccionUnidadSinRequerimientoPage({Key? key}) : super(key: key);

  @override
  State<InspeccionUnidadSinRequerimientoPage> createState() => _InspeccionUnidadSinRequerimientoPageState();
}

class _InspeccionUnidadSinRequerimientoPageState extends State<InspeccionUnidadSinRequerimientoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inspección de unidad sin req.', style: $styles.textStyles.h3)),
      body: Container(),
    );
  }
}
