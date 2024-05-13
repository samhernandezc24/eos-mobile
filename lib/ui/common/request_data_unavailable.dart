import 'package:eos_mobile/shared/shared_libraries.dart';

class RequestDataUnavailable extends StatelessWidget {
  const RequestDataUnavailable({required this.onRefresh, Key? key, this.title, this.message}) : super(key: key);

  final String? title;
  final String? message;
  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info, color: Theme.of(context).colorScheme.secondary, size: 64),

          Gap($styles.insets.sm),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg * 1.5),
            child   : Text(
              title ?? 'Aún no hay datos',
              style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child   : Text(
              message ?? 'Actualiza la información.',
              textAlign: TextAlign.center,
            ),
          ),

          FilledButton.icon(
            onPressed : onRefresh,
            icon      : const Icon(Icons.refresh),
            label     : Text($strings.refreshButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
