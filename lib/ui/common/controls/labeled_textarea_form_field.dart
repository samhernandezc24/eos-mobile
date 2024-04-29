import 'package:eos_mobile/shared/shared_libraries.dart';

class LabeledTextareaFormField extends StatelessWidget {
  const LabeledTextareaFormField({
    required this.controller,
    required this.labelText,
    Key? key,
    this.maxCharacters,
    this.maxLines = 5,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.hintText,
    this.validator,
    this.autoFocus = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final int? maxCharacters;
  final int maxLines;
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
          maxLines: maxLines,
          maxLength: maxCharacters,
          decoration: InputDecoration(
            contentPadding  : AppConstants.kDefaultContentPadding,
            hintText        : hintText,
          ),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
        ),
      ],
    );
  }
}
