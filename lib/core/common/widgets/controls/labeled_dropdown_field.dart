import 'package:eos_mobile/shared/shared.dart';

class LabeledDropdownField extends StatelessWidget {
  const LabeledDropdownField({
    required this.labelText,
    required this.onChanged,
    required this.items,
    Key? key,
    this.hintText,
    this.value,
  }) : super(key: key);

  final String labelText;
  final String? hintText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          labelText,
          style: $styles.textStyles.label,
        ),
        Gap($styles.insets.xs),
        DropdownButtonFormField(
          value: value,
          menuMaxHeight: 280,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: $styles.insets.sm - 6,
              horizontal: $styles.insets.xs + 2,
            ),
            hintText: hintText,
          ),
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
