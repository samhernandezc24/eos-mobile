import 'package:eos_mobile/core/common/widgets/controls/circle_buttons.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionUnidadSinRequerimientoPage extends StatefulWidget {
  const InspeccionUnidadSinRequerimientoPage({Key? key}) : super(key: key);

  @override
  State<InspeccionUnidadSinRequerimientoPage> createState() =>  _InspeccionSinRequerimientoPageState();
}

class _InspeccionSinRequerimientoPageState extends State<InspeccionUnidadSinRequerimientoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackBtn.close(
          iconColor: Theme.of(context).primaryColor,
        ),
      ),
      body: Container(),
    );
  }
}
