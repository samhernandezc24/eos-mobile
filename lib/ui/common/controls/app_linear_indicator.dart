import 'package:eos_mobile/shared/shared_libraries.dart';

class AppLinearIndicator extends StatelessWidget {
  const AppLinearIndicator({
    Key? key,
    this.color,
    this.value,
    this.width      = double.infinity,
    this.height     = 4.0,
    this.minHeight  = 4.0,
  }) : assert(value == null || (value >= 0 && value <= 1), 'El valor del progress debe estar entre 0 y 1'),
       super(key: key);

  final Color? color;
  final double? value;
  final double? width;
  final double? height;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    final progress = (value == null || value! < .05) ? null : value;

    return SizedBox(
      width   : width,
      height  : height,
      child   : LinearProgressIndicator(
        backgroundColor : color?.withOpacity(0.3) ?? Theme.of(context).primaryColor.withOpacity(0.3),
        color           : color ?? Theme.of(context).primaryColor,
        value           : progress,
        minHeight       : minHeight,
      ),
    );
  }
}
