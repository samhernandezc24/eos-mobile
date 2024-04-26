import 'package:eos_mobile/shared/shared_libraries.dart';

class LabeledDropdownFormField<T> extends StatelessWidget {
  const LabeledDropdownFormField({
    required this.label,
    Key? key,
    this.hintText,
    this.items,
    this.value,
    this.onChanged,
    this.itemBuilder,
    this.validator,
  }) : super(key: key);

  final String label;
  final String? hintText;
  final List<T>? items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final Widget Function(T)? itemBuilder;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(label, style: $styles.textStyles.label),
        Gap($styles.insets.xs),
        DropdownButtonFormField<T>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
          validator: validator,
        ),
      ],
    );
  }
}
