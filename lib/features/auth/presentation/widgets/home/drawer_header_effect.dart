import 'package:eos_mobile/shared/shared.dart';

class DrawerHeaderEffect extends StatelessWidget {
  const DrawerHeaderEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Theme.of(context).colorScheme.inverseSurface.withOpacity(0.2),
            Theme.of(context).colorScheme.inverseSurface.withOpacity(0.3),
            Theme.of(context).colorScheme.inverseSurface.withOpacity(0.2),
          ],
          stops: const <double>[0, 0.5, 1],
        ),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // AVATAR LOADING
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
            ),
            Gap($styles.insets.xs),
            // NAME LOADING
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 125,
                  height: 24,
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular($styles.insets.sm)),
                ),
              ],
            ),
            Gap($styles.insets.xs),
            // EMAIL LOADING
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 225,
                  height: 24,
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular($styles.insets.sm)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
