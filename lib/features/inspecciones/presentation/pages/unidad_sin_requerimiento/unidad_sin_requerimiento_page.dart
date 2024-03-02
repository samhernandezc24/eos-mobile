import 'package:eos_mobile/core/common/widgets/controls/simple_checkbox.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionUnidadSinRequerimientoPage extends StatefulWidget {
  const InspeccionUnidadSinRequerimientoPage({super.key});

  @override
  State<InspeccionUnidadSinRequerimientoPage> createState() =>
      _InspeccionSinRequerimientoPageState();
}

class _InspeccionSinRequerimientoPageState
    extends State<InspeccionUnidadSinRequerimientoPage> {

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SimpleCheckbox(
          isActive: _isChecked,
          label: 'Unidad Temporal',
          onChanged: (bool? newValue) {
            setState(() {
              _isChecked = newValue ?? false;
            });
          },
        ),
      ),
    );
  }
}
