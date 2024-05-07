import 'package:eos_mobile/shared/shared_libraries.dart';

class LabeledTextareaFormField extends StatelessWidget {
  const LabeledTextareaFormField({
    required this.controller,
    required this.labelText,
    Key? key,
    this.maxCharacters,
    this.maxLines         = 5,
    this.keyboardType     = TextInputType.text,
    this.textInputAction  = TextInputAction.next,
    this.autoFocus        = false,
    this.hintText,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final int? maxCharacters;
  final int maxLines;
  final bool autoFocus;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(labelText, style: $styles.textStyles.label),

        Gap($styles.insets.xs),

        TextFormField(
          autovalidateMode  : AutovalidateMode.onUserInteraction,
          autofocus         : autoFocus,
          controller        : controller,
          decoration        : InputDecoration(
            contentPadding  : Globals.kDefaultContentPadding,
            hintText        : hintText,
          ),
          keyboardType      : keyboardType,
          maxLines          : maxLines,
          maxLength         : maxCharacters,
          textInputAction   : textInputAction,
          validator         : validator,
        ),
      ],
    );
  }
}
