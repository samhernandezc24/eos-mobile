import 'package:eos_mobile/shared/shared_libraries.dart';

class BasicTextFormField extends StatelessWidget {
  const BasicTextFormField({
    required this.controller,
    Key? key,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: $styles.insets.sm - 3,
          horizontal: $styles.insets.xs + 2,
        ),
        hintText: hintText ?? '',
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
    );
  }
}
