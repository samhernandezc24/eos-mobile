import 'package:eos_mobile/shared/shared.dart';

export 'app_colors.dart';

@immutable
class AppStyles {
  AppStyles({Size? screenSize}) {
    if (screenSize == null) {
      scale = 1;
      return;
    }

    final shortesSide = screenSize.shortestSide;
    const tabletXl = 1000;
    const tabletLg = 800;

    if (shortesSide > tabletXl) {
      scale = 1.2;
    } else if (shortesSide > tabletLg) {
      scale = 1.1;
    } else {
      scale = 1;
    }
  }

  late final double scale;

  /// Los colores actuales de la aplicación.
  /// 
  /// Algunos valores no incluidos se dejan tal y 
  /// como se representan en el tema de la aplicación.
  final AppColors colors = AppColors();

  /// Las velocidades de las duraciones o transiciones
  /// de la aplicación.
  final _Times times = _Times();
}

@immutable
class _Times {
  final Duration fast           = const Duration(milliseconds: 300);
  final Duration medium         = const Duration(milliseconds: 600);
  final Duration slow           = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}
