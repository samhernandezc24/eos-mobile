import 'package:eos_mobile/shared/shared.dart';

class CardViewIcon extends StatelessWidget {
  const CardViewIcon({
    required this.icon,
    required this.title,
    this.color,
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final iconSize = screenSize.width * 0.12;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular($styles.corners.md),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Column(
          children: [
            Center(
              child: Container(
                height: iconSize,
                width: iconSize,
                decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  border: Border.all(
                    color: Theme.of(context).highlightColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular($styles.corners.lg),
                ),
                child: Center(
                  child: icon,
                ),
              ),
            ),
            const Gap(6),
            Flexible(
              child: Text(
                title,
                style: $styles.textStyles.bodySmallBold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
