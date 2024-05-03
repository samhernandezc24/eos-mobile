import 'package:eos_mobile/shared/shared_libraries.dart';

class CustomBoxContainer extends StatelessWidget {
  const CustomBoxContainer({
    required this.title,
    Key? key,
    this.content,
    this.borderColor,
    this.backgroundColor,
    this.iconColor,
  }) : super(key: key);

  final String title;
  final String? content;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.md),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular($styles.corners.md),
        color: backgroundColor ?? Theme.of(context).cardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info, color: iconColor ?? Theme.of(context).primaryColor, size: 32),

          Gap($styles.insets.xs),

          // TITULO:
          Text(title, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600), softWrap: true, textAlign: TextAlign.center),

          Gap($styles.insets.xs),

          // CONTENIDO:
          if (content != null) Text(content!, style: $styles.textStyles.bodySmall, softWrap: true, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
