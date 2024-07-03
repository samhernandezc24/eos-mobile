import 'package:eos_mobile/shared/shared_libs.dart';

class LabeledPasswordFormField extends StatefulWidget {
  const LabeledPasswordFormField({
    required this.controller,
    Key? key,
    this.label,
    this.hintText,
    this.autoFocus        = false,
    this.isEnabled        = true,
    this.readOnly         = false,
    this.textInputAction  = TextInputAction.next,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final bool autoFocus;
  final bool isEnabled;
  final bool readOnly;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  @override
  State<LabeledPasswordFormField> createState() => _LabeledPasswordFormFieldState();
}

class _LabeledPasswordFormFieldState extends State<LabeledPasswordFormField> {
  // PROPERTIES
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null && widget.label!.isNotEmpty) ...[
          Text(widget.label ?? '', style: $styles.textStyles.label),
          Gap($styles.insets.xs),
        ],
        TextFormField(
          autofocus: widget.autoFocus,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          decoration: InputDecoration(
            contentPadding  : Globals.kDefaultContentPadding,
            hintText        : widget.hintText ?? '',
            filled          : widget.isEnabled,
            fillColor       : widget.isEnabled
                ? Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0.3)
                : Theme.of(context).inputDecorationTheme.fillColor,
            suffixIcon      : IconButton(
              icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
              color: Theme.of(context).hintColor,
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          obscureText: !_isPasswordVisible,
          readOnly: widget.readOnly,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
        ),
      ],
    );
  }
}
