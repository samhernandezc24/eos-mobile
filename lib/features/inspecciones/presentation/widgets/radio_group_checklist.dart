import 'package:eos_mobile/shared/shared.dart';

class RadioGroupChecklist extends StatelessWidget {
  const RadioGroupChecklist({
    required this.label,
    required this.options,
    required void Function(String?) onChanged,
    this.selectedValue,
    Key? key,
  })  : _onChanged = onChanged,
        super(key: key);

  final String label;
  final List<String> options;
  final String? selectedValue;
  final void Function(String?) _onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: $styles.insets.sm),
          child: Text(
            label,
            style: $styles.textStyles.label,
          ),
        ),
        Wrap(
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: option,
                  groupValue: selectedValue,
                  onChanged: _onChanged,
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
