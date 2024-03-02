import 'package:eos_mobile/core/utils/haptics_utils.dart';
import 'package:eos_mobile/shared/shared.dart';

class SimpleCheckbox extends StatelessWidget {
  const SimpleCheckbox({
    required this.isActive,
    required this.label,
    required void Function(bool?) onChanged,
    Key? key,
  }) : _onChanged = onChanged,
       super(key: key);

  final bool isActive;
  final String label;
  final void Function(bool?) _onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          label,
          style: $styles.textStyles.label,
        ),
        // Gap($styles.insets.xs),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular($styles.corners.sm)),
          ),
          child: Checkbox(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular($styles.corners.sm))),
            value: isActive,
            visualDensity: const VisualDensity(horizontal: 0.5, vertical: 0.5),
            checkColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.75),
            activeColor: Theme.of(context).primaryColor.withOpacity(0.75),
            onChanged: (bool? isActive) {
              HapticsUtils.mediumImpact();
              _onChanged.call(isActive);
            },
          ),
        ),
      ],
    );
  }
}
