import 'package:eos_mobile/shared/shared.dart';

class LabeledDropdownFormField<T> extends StatelessWidget {
  const LabeledDropdownFormField({
    required this.label,
    Key? key,
    this.hintText,
    this.items,
    this.value,
    this.onChanged,
    this.itemBuilder,
  }) : super(key: key);

  final String label;
  final String? hintText;
  final List<T>? items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final Widget Function(T)? itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(label, style: $styles.textStyles.label),
        Gap($styles.insets.xs),
        DropdownButtonFormField<T>(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: $styles.insets.sm - 3,
              horizontal: $styles.insets.xs + 2,
            ),
            hintText: hintText,
          ),
          isExpanded: true,
          items: items?.map<DropdownMenuItem<T>>((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: itemBuilder != null ? itemBuilder!(item) : Text(item.toString()),
            );
          }).toList(),
          onChanged: onChanged,
          menuMaxHeight: 280,
          value: value,
        ),
      ],
    );
  }
}
