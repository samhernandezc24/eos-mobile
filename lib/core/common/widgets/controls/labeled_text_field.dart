import 'package:eos_mobile/shared/shared.dart';

class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    required this.controller,
    required this.labelText,
    Key? key,
    this.isReadOnly = false,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.hintText,
    this.validator,
    this.autoFocus = false,
  }) : super(key: key);

  final TextEditingController controller;
  final TextAlign textAlign;
  final String labelText;
  final String? hintText;
  final bool isReadOnly;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          labelText,
          style: $styles.textStyles.label,
        ),
        Gap($styles.insets.xs),
        TextFormField(
          controller: controller,
          autofocus: autoFocus,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: $styles.insets.sm - 6,
              horizontal: $styles.insets.xs + 2,
            ),
            hintText: hintText,
          ),
          textAlign: textAlign,
          readOnly: isReadOnly,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
        ),
      ],
    );
  }
}
