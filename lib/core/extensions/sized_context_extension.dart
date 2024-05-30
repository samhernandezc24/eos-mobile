import 'package:eos_mobile/shared/shared_libraries.dart';

extension SizedContext on BuildContext {
  /// Retorna lo mismo que `MediaQuery.of(context)`.
  MediaQueryData get mq => MediaQuery.of(this);

  /// Retorna si la Orientation es landscape.
  bool get isLandscape => mq.orientation == Orientation.landscape;

  /// Retorna lo mismo que `MediaQuery.of(context).size`.
  Size get sizePx => mq.size;

  /// Retorna lo mismo que `MediaQuery.of(context).size.width`.
  double get widthPx => sizePx.width;

  /// Retorna lo mismo que `MediaQuery.of(context).size.height`.
  double get heightPx => sizePx.height;

  /// Retorna los pixeles diagonales de la pantalla.
  double get diagonalPx {
    final Size s = sizePx;
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  /// Retorna la fracción (0-1) del width de la pantalla en píxeles.
  double widthPct(double fraction) => fraction * widthPx;

  /// Retorna la fracción (0-1) del height de la pantalla en píxeles.
  double heightPct(double fraction) => fraction * heightPx;
}
