import 'package:eos_mobile/shared/shared_libraries.dart';

class TopLeft extends Align {
  const TopLeft({
    Key? key,
    double? widthFactor,
    double? heightFactor,
    Widget? child,
  }) : super(
          key: key,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: child,
          alignment: Alignment.topLeft,
        );
}

class CenterLeft extends Align {
  const CenterLeft({
    Key? key,
    double? widthFactor,
    double? heightFactor,
    Widget? child,
  }) : super(
          key: key,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: child,
          alignment: Alignment.centerLeft,
        );
}

class BottomCenter extends Align {
  const BottomCenter({
    Key? key,
    double? widthFactor,
    double? heightFactor,
    Widget? child,
  }) : super(
          key: key,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: child,
          alignment: Alignment.bottomCenter,
        );
}
