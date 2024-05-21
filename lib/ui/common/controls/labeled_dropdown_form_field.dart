import 'package:eos_mobile/shared/shared_libraries.dart';

class LabeledDropdownFormField<T> extends StatelessWidget {
  const LabeledDropdownFormField({
    required this.label,
    required this.items,
    Key? key,
    this.hintText,
    this.onChanged,
    this.value,
    this.itemBuilder,
    this.validator,
  }) : super(key: key);

  final String label;
  final String? hintText;
  final List<T> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final Widget Function(T)? itemBuilder;
  final FormFieldValidator<T>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: $styles.textStyles.label),

        Gap($styles.insets.xs),

        DropdownButtonFormField<T>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration  : InputDecoration(
            contentPadding  : Globals.kDefaultContentPadding,
            hintText        : hintText ?? 'Seleccionar',
          ),
          value: value,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: itemBuilder != null ? itemBuilder!(item) : Text(item.toString()),
            );
          }).toList(),
          onChanged: onChanged,
          menuMaxHeight: 280,
          validator: validator,
          isExpanded: true,
        ),
      ],
    );
  }
}
