import 'package:eos_mobile/shared/shared_libs.dart';

class ErrorServerMessage extends StatelessWidget {
  const ErrorServerMessage({required this.onPressed, Key? key, this.message}) : super(key: key);

  final String? message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment : MainAxisAlignment.center,
        children          : <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),

          Gap($styles.insets.sm),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg * 1.5),
            child   : Text(
              AppStrings.errorServerTitle,
              style     : $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600),
              textAlign : TextAlign.center,
            ),
          ),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child   : Text(
              message ?? 'Se produjo un error inesperado.',
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
          ),

          FilledButton.icon(
            onPressed : onPressed,
            icon      : const Icon(Icons.refresh),
            label     : Text(AppStrings.btnRetryText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
