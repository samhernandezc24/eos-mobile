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
    this.isEnabled        = true,
    this.isReadOnly       = false,
    this.hintText,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final int? maxCharacters;
  final int maxLines;
  final bool autoFocus;
  final bool isEnabled;
  final bool isReadOnly;
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
            fillColor       : isEnabled
                ? Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0.3)
                : Theme.of(context).inputDecorationTheme.fillColor,
            filled          : true,
            contentPadding  : Globals.kDefaultContentPadding,
            hintText        : hintText,
          ),
          keyboardType      : keyboardType,
          maxLines          : maxLines,
          maxLength         : maxCharacters,
          readOnly          : isReadOnly,
          style             : const TextStyle(height: 1.3, letterSpacing: 0.01),
          textInputAction   : textInputAction,
          validator         : validator,
        ),
      ],
    );
  }
}
