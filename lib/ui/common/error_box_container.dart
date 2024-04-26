import 'package:eos_mobile/shared/shared_libraries.dart';

class ErrorBoxContainer extends StatelessWidget {
  const ErrorBoxContainer({required this.errorMessage, required this.onPressed, Key? key}) : super(key: key);

  final String errorMessage;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all($styles.insets.sm),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.error),
        borderRadius: BorderRadius.circular($styles.corners.md),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 32),
          Gap($styles.insets.xs),
          Text(
            errorMessage,
            style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.error),
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          TextButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.refresh),
            label: Text($strings.retryButtonText),
          ),
        ],
      ),
    );
  }
}
