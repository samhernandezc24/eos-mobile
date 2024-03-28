import 'package:eos_mobile/shared/shared.dart';

class LabeledTextField extends StatefulWidget {
  const LabeledTextField({
    required this.controller,
    required this.labelText,
    Key? key,
    this.isReadOnly = false,
    this.isPassword = false,
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
  final bool isPassword;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final bool autoFocus;

  @override
  State<LabeledTextField> createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  // STATES
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.labelText,
          style: $styles.textStyles.label,
        ),

        Gap($styles.insets.xs),

        TextFormField(
          controller: widget.controller,
          autofocus: widget.autoFocus,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: $styles.insets.sm - 3,
              horizontal: $styles.insets.xs + 2,
            ),
            hintText: widget.hintText,
            suffixIcon: widget.isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  color: Theme.of(context).hintColor,
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    ),
                  )
                : null,
          ),
          obscureText: widget.isPassword && !_isPasswordVisible,
          textAlign: widget.textAlign,
          readOnly: widget.isReadOnly,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
        ),
      ],
    );
  }
}
