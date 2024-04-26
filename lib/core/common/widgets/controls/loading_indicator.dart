import 'package:eos_mobile/shared/shared_libraries.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    this.color,
    this.value,
    this.width,
    this.height,
    this.strokeWidth,
  }) : assert(value == null || (value >= 0 && value <= 1),
          'El valor del progress debe estar entre 0 y 1',
        ),
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
      width: width ?? 40,
      height: height ?? 40,
      child: CircularProgressIndicator(
        color: color ?? Theme.of(context).canvasColor,
        value: progress,
        strokeWidth: strokeWidth ?? 1,
      ),
    );
  }
}
