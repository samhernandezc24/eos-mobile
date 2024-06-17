part of '../home_page.dart';

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({required this.onPressed, required this.data, Key? key}) : super(key: key);

  final void Function(HomeData data) onPressed;
  final HomeData data;

  @override
  Widget build(BuildContext context) {
    Color startColor;
    Color endColor;
    Color iconBackgroundColor;
    Color iconColor;
    Color textColor;

    if (Theme.of(context).brightness == Brightness.dark) {
      startColor          = Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.8);
      endColor            = Theme.of(context).colorScheme.secondaryContainer;
      iconBackgroundColor = Theme.of(context).colorScheme.secondary.withOpacity(0.2);
      iconColor           = Theme.of(context).colorScheme.secondary;
      textColor           = Theme.of(context).colorScheme.onSecondaryContainer;
    } else {
      startColor          = Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8);
      endColor            = Theme.of(context).colorScheme.primaryContainer;
      iconBackgroundColor = Theme.of(context).colorScheme.primary.withOpacity(0.2);
      iconColor           = Theme.of(context).colorScheme.primary;
      textColor           = Theme.of(context).colorScheme.onPrimaryContainer;
    }

    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular($styles.insets.xs),
        child: AppBtn.basic(
          onPressed: () => onPressed(data),
          semanticLabel: data.title,
          child: Container(
            decoration: BoxDecoration(
               gradient: LinearGradient(
                colors  : <Color>[startColor, endColor],
                begin   : Alignment.topLeft,
                end     : Alignment.bottomRight,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: iconBackgroundColor),
                  child: Icon(data.icon, size: 30, color: iconColor),
                ),
                Gap($styles.insets.sm),
                Text(data.title, style: $styles.textStyles.bodySmallBold.copyWith(color: textColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
