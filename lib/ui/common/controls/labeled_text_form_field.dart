import 'package:eos_mobile/shared/shared_libs.dart';

class LabeledTextFormField extends StatelessWidget {
  const LabeledTextFormField({
    required this.controller,
    Key? key,
    this.label,
    this.hintText,
    this.autoFocus        = false,
    this.isEnabled        = true,
    this.readOnly         = false,
    this.textAlign,
    this.keyboardType     = TextInputType.text,
    this.textInputAction  = TextInputAction.next,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final TextAlign? textAlign;
  final String? label;
  final String? hintText;
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
          autofocus: autoFocus,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          decoration: InputDecoration(
            contentPadding  : Globals.kDefaultContentPadding,
            hintText        : hintText ?? '',
            fillColor       : isEnabled
                ? Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0.3)
                : Theme.of(context).inputDecorationTheme.fillColor,
          ),
          keyboardType: keyboardType,
          readOnly: readOnly,
          textInputAction: textInputAction,
          textAlign: textAlign ?? TextAlign.start,
          validator: validator,
        ),
      ],
    );
  }
}
