import 'package:eos_mobile/shared/shared_libs.dart';

class AppModalRoute extends PageRouteBuilder<void> {
  AppModalRoute({required this.child}) : super(
    transitionDuration  : $styles.times.pageTransition,
    pageBuilder         : (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      const Offset begin  = Offset(0, 1);
      const Offset end    = Offset.zero;
      const Cubic curve   = Curves.ease;

      final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive<Offset>(tween), child: child);
    },
    fullscreenDialog: true,
  );

  final Widget child;
}
