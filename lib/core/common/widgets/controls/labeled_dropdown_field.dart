import 'package:eos_mobile/shared/shared.dart';

class LabeledDropdownFormField extends StatelessWidget {
  const LabeledDropdownFormField({
    required this.labelText,
    required this.onChanged,
    required this.items,
    Key? key,
    this.hintText,
    this.value,
  }) : super(key: key);

  final String labelText;
  final String? hintText;
  final List<dynamic> items;
  final String? value;
  final ValueChanged<dynamic> onChanged;

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

        DropdownButtonFormField<dynamic>(
          value: value,
          menuMaxHeight: 280,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: $styles.insets.sm - 3,
              horizontal: $styles.insets.xs + 2,
            ),
            hintText: hintText,
          ),
          items: items.map<DropdownMenuItem<dynamic>>((item) {
            return DropdownMenuItem<String>(
              value: item.toString(),
              child: Text(item.toString()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
