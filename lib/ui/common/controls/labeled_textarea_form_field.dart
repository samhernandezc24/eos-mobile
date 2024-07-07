import 'package:eos_mobile/shared/shared_libs.dart';

class LabeledTextareaFormField extends StatelessWidget {
  const LabeledTextareaFormField({
    required this.controller,
    Key? key,
    this.label,
    this.hintText,
    this.autoFocus        = false,
    this.isEnabled        = true,
    this.readOnly         = false,
    this.maxCharacters,
    this.maxLines         = 5,
    this.keyboardType     = TextInputType.text,
    this.textInputAction  = TextInputAction.next,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final int? maxCharacters;
  final int maxLines;
  final bool autoFocus;
  final bool isEnabled;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null && label!.isNotEmpty) ...[
          Text(label ?? '', style: $styles.textStyles.label),
          Gap($styles.insets.xs),
        ],
        TextFormField(
          autofocus         : autoFocus,
          autovalidateMode  : AutovalidateMode.onUserInteraction,
          controller        : controller,
          decoration        : InputDecoration(
            hintText        : hintText ?? '',
            contentPadding  : Globals.kDefaultContentPadding,
            fillColor       : isEnabled
                ? Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0.3)
                : Theme.of(context).inputDecorationTheme.fillColor,
          ),
          keyboardType      : keyboardType,
          maxLines          : maxLines,
          maxLength         : maxCharacters,
          readOnly          : readOnly,
          style             : const TextStyle(height: 1.3, letterSpacing: 0.01),
          textInputAction   : textInputAction,
          validator         : validator,
        ),
      ],
    );
  }
}
