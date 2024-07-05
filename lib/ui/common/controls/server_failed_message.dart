import 'package:eos_mobile/shared/shared_libs.dart';

class ServerFailedDialog extends StatelessWidget {
  const ServerFailedDialog({required this.message, Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment : MainAxisAlignment.center,
        children          : <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 48),
        ],
      ),
      content: Text(message, style: $styles.textStyles.title2.copyWith(height: 1.5)),
      actions: <Widget>[
        TextButton(
          onPressed : () => Navigator.pop(context, AppStrings.btnAcceptText),
          child     : Text(AppStrings.btnAcceptText, style: $styles.textStyles.button),
        ),
      ],
    );
  }
}
