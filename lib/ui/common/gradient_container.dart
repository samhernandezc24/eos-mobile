import 'package:eos_mobile/shared/shared_libs.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(
    this.colors,
    this.stops, {
    Key? key,
    this.child,
    this.width,
    this.height,
    this.alignment,
    this.begin,
    this.end,
    this.blendMode,
    this.borderRadius,
  }) : super(key: key);

  final List<Color> colors;
  final List<double> stops;
  final double? width;
  final double? height;
  final Widget? child;
  final Alignment? begin;
  final Alignment? end;
  final Alignment? alignment;
  final BlendMode? blendMode;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin   : begin ?? Alignment.centerLeft,
          end     : end ?? Alignment.centerRight,
          colors  : colors,
          stops   : stops,
        ),
        backgroundBlendMode: blendMode,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class HorizontalGradient extends GradientContainer {
  const HorizontalGradient(
    List<Color> colors,
    List<double> stops, {
    Key? key,
    double? width,
    double? height,
    Widget? child,
    Alignment? begin,
    Alignment? end,
    Alignment? alignment,
    BlendMode? blendMode,
    BorderRadius? borderRadius,
  }) : super(
          colors,
          stops,
          key           : key,
          width         : width,
          height        : height,
          child         : child,
          begin         : begin,
          end           : end,
          alignment     : alignment,
          blendMode     : blendMode,
          borderRadius  : borderRadius,
        );
  }

  class VerticalGradient extends GradientContainer {
    const VerticalGradient(
      List<Color> colors,
      List<double> stops, {
      Key? key,
      double? width,
      double? height,
      Widget? child,
      Alignment? begin  = Alignment.topCenter,
      Alignment? end    = Alignment.bottomCenter,
      Alignment? alignment,
      BlendMode? blendMode,
      BorderRadius? borderRadius,
    }) : super(
          colors,
          stops,
          key           : key,
          width         : width,
          height        : height,
          child         : child,
          begin         : begin,
          end           : end,
          alignment     : alignment,
          blendMode     : blendMode,
          borderRadius  : borderRadius,
        );
}
