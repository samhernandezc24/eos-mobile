import 'package:eos_mobile/core/utils/haptics_utils.dart';
import 'package:eos_mobile/shared/shared.dart';

class SimpleCheckbox extends StatelessWidget {
  const SimpleCheckbox({
    required this.isActive,
    required this.label,
    required this.onChanged,
    super.key,
  });

  final bool isActive;
  final String label;
  final Function(bool? onChanged) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Checkbox(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            value: isActive,
            visualDensity: const VisualDensity(horizontal: 0.5, vertical: 0.5),
            checkColor: Colors.black.withOpacity(0.75),
            activeColor: Colors.white.withOpacity(0.75),
            onChanged: (bool? isActive) {
              HapticsUtils.mediumImpact();
              onChanged.call(isActive);
            },
          ),
        ),
      ],
    );
  }
}
