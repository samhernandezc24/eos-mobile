import 'package:eos_mobile/shared/shared_libraries.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    Key? key,
    this.color,
    this.value,
    this.width,
    this.height,
    this.strokeWidth,
  }) : assert(value == null || (value >= 0 && value <= 1), 'El valor del progress debe estar entre 0 y 1'),
       super(key: key);

  final Color? color;
  final double? value;
  final double? width;
  final double? height;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    final progress = (value == null || value! < .05) ? null : value;

    return SizedBox(
      width   : width ?? 30,
      height  : height ?? 30,
      child   : CircularProgressIndicator(
        color       : color ?? Theme.of(context).primaryColor,
        value       : progress,
        strokeWidth : strokeWidth ?? 3,
      ),
    );
  }
}
