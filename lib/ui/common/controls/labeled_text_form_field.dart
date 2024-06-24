import 'package:eos_mobile/shared/shared_libraries.dart';

class LabeledTextFormField extends StatelessWidget {
  const LabeledTextFormField({
    required this.controller,
    required this.label,
    Key? key,
    this.hintText,
    this.validator,
    this.keyboardType     = TextInputType.text,
    this.textInputAction  = TextInputAction.next,
    this.textAlign        = TextAlign.start,
    this.autoFocus        = false,
    this.isReadOnly       = false,
    this.isEnabled        = true,
    this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final TextAlign textAlign;
  final String label;
  final String? hintText;
  final bool isReadOnly;
  final bool autoFocus;
  final bool isEnabled;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: $styles.textStyles.label),

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
            hintText        : hintText ?? '',
          ),
          readOnly        : isReadOnly,
          keyboardType    : keyboardType,
          onTap           : onTap,
          textInputAction : textInputAction,
          textAlign       : textAlign,
          validator       : validator,
        ),
      ],
    );
  }
}
