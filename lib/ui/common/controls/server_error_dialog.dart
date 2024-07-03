import 'package:eos_mobile/shared/shared_libs.dart';

class ServerErrorDialog extends StatelessWidget {
  const ServerErrorDialog({required this.message, Key? key}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 48),
      ),
      content: Text(message, style: $styles.textStyles.body.copyWith(height: 1.3)),
      actions: <Widget>[
        TextButton(
          onPressed : () => Navigator.pop(context, AppStrings.btnAcceptText),
          child     : Text(AppStrings.btnAcceptText, style: $styles.textStyles.button),
        ),
      ],
    );
  }
}
