import 'package:eos_mobile/shared/shared_libraries.dart';

/// Caja de color que puede desvanecerse dentro y fuera, debe producir un mejor rendimiento que el
/// desvanecimiento con una capa adicional de Opacidad.
class FadeColorTransition extends StatelessWidget {
  const FadeColorTransition({required this.animation, required this.color, Key? key}) : super(key: key);

  final Animation<double> animation;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) => Container(color: color.withOpacity(animation.value)),
    );
  }
}
