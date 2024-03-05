import 'package:eos_mobile/shared/shared.dart';

class CardViewIcon extends StatelessWidget {
  const CardViewIcon({
    required this.icon,
    required this.title,
    this.color,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.of(context).size.width * 0.14;

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular($styles.corners.md),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: EdgeInsets.all($styles.insets.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                child: icon,
              ),
              Gap($styles.insets.sm),
              Text(
                title,
                style: $styles.textStyles.bodySmallBold.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
