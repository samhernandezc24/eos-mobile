import 'package:eos_mobile/shared/shared.dart';

class FadeColorTransition extends StatelessWidget {
  const FadeColorTransition({
    required this.animation,
    required this.color,
    super.key,
  });

  final Animation<double> animation;
  final Color color;

  @override
  Widget build( BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) => Container(color: color.withOpacity(animation.value)),
    );
  }
}
