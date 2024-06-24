import 'package:eos_mobile/shared/shared_libraries.dart';

class LabeledPasswordFormField extends StatefulWidget {
  const LabeledPasswordFormField({
    required this.controller,
    required this.label,
    Key? key,
    this.hintText,
    this.validator,
    this.textInputAction  = TextInputAction.next,
    this.isPassword       = true,
    this.autoFocus        = false,
    this.isEnabled        = true,
    this.isReadOnly       = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String? hintText;
  final bool isPassword;
  final bool isEnabled;
  final bool isReadOnly;
  final bool autoFocus;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;

  @override
  State<LabeledPasswordFormField> createState() => _LabeledPasswordFormFieldState();
}

class _LabeledPasswordFormFieldState extends State<LabeledPasswordFormField> {
  /// PROPERTIES
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.label, style: $styles.textStyles.label),

        Gap($styles.insets.xs),

        TextFormField(
          autovalidateMode  : AutovalidateMode.onUserInteraction,
          autofocus         : widget.autoFocus,
          controller        : widget.controller,
          enabled           : widget.isEnabled,
          decoration        : InputDecoration(
            fillColor       : Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0.4),
            filled          : true,
            contentPadding  : Globals.kDefaultContentPadding,
            hintText        : widget.hintText ?? '',
            suffixIcon      : widget.isPassword
                ? IconButton(
                    color     : Theme.of(context).hintColor,
                    onPressed : () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon      : Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                  )
                : null,
          ),
          obscureText     : widget.isPassword && !_isPasswordVisible,
          readOnly        : widget.isReadOnly,
          keyboardType    : TextInputType.visiblePassword,
          textInputAction : widget.textInputAction,
          validator       : widget.validator,
        ),
      ],
    );
  }
}
