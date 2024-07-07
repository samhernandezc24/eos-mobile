import 'package:eos_mobile/shared/shared_libs.dart';

class EmptyResultsMessage extends StatelessWidget {
  const EmptyResultsMessage({
    Key? key,
    this.title,
    this.message,
  }) : super(key: key);

  final String? title;
  final String? message;

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
              title ?? 'No hay resultados',
              style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child   : Text(
              message ?? 'Actualiza la búsqueda.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
