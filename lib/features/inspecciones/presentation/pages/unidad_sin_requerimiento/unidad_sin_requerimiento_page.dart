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
        padding: EdgeInsets.all($styles.insets.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SimpleCheckbox(
              isActive: _isChecked,
              label: 'Unidad Temporal',
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked = newValue ?? false;
                });
              },
            ),
            AnimatedSwitcher(
              duration: $styles.times.fast,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  ),
                );
              },
              child: _isChecked
                  ? TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.local_shipping),
                      label: const Text('Nueva Unidad Temporal'),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
