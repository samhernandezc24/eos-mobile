import 'package:eos_mobile/shared/shared_libraries.dart';

class ServerFailedDialog extends StatelessWidget {
  const ServerFailedDialog({required this.errorMessage, Key? key}) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment : MainAxisAlignment.center,
        children          : <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 48),
        ],
      ),
      content: Text(
        errorMessage,
        style: $styles.textStyles.title2.copyWith(height: 1.5),
      ),
      actions: <Widget>[
        TextButton(
          onPressed : () => Navigator.pop(context, $strings.acceptButtonText),
          child     : Text($strings.acceptButtonText, style: $styles.textStyles.button),
        ),
      ],
    );
  }
}
