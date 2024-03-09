import 'package:eos_mobile/shared/shared.dart';

@immutable
class AppStyles {
  AppStyles({Size? screenSize}) {
    if (screenSize == null) {
      scale = 1;
      return;
    }

    final shortesSide = screenSize.shortestSide;
    const tabletXl    = 1000;
    const tabletLg    = 800;

    if (shortesSide > tabletXl) {
      scale = 1.2;
    } else if (shortesSide > tabletLg) {
      scale = 1.1;
    } else {
      scale = 1;
    }
  }

  late final double scale;

  /// Radios de esquina con bordes redondeados.
  late final _Corners corners = _Corners();

  /// Valores de los padding y margin.
  late final _Insets insets = _Insets(scale);

  /// Estilos de los textos.
  late final _TextStyles textStyles = _TextStyles(scale);

  /// Las velocidades de las duraciones o transiciones
  /// de la aplicación.
  final _Times times = _Times();
}

@immutable
class _TextStyles {
  _TextStyles(this._scale);
  final double _scale;

  final TextStyle _mainTextFont = const TextStyle(fontFamily: 'Font72');

  TextStyle get titleFont     => _mainTextFont;
  TextStyle get eosTitleFont  => _mainTextFont;
  TextStyle get contentFont   => _mainTextFont;

  late final TextStyle eosTitle       = _createFont(eosTitleFont, sizePx: 64, heightPx: 56);

  late final TextStyle h1             = _createFont(titleFont, sizePx: 34, heightPx: 40);
  late final TextStyle h2             = _createFont(titleFont, sizePx: 24, heightPx: 32);
  late final TextStyle h3             = _createFont(titleFont, sizePx: 20, heightPx: 28, weight: FontWeight.w600);
  late final TextStyle h4             = _createFont(titleFont, sizePx: 16, heightPx: 24, spacingPc: 5, weight: FontWeight.w600);

  late final TextStyle title1         = _createFont(titleFont, sizePx: 18, heightPx: 26, spacingPc: 5);
  late final TextStyle title2         = _createFont(contentFont, sizePx: 16, heightPx: 18.38);

  late final TextStyle body           = _createFont(contentFont, sizePx: 16, heightPx: 26);
  late final TextStyle bodyBold       = _createFont(contentFont, sizePx: 16, heightPx: 26, weight: FontWeight.w600);
  late final TextStyle bodySmall      = _createFont(contentFont, sizePx: 14, heightPx: 23);
  late final TextStyle bodySmallBold  = _createFont(contentFont, sizePx: 14, heightPx: 23, weight: FontWeight.w600);

  late final TextStyle button         = _createFont(contentFont, sizePx: 16, weight: FontWeight.w500, spacingPc: 2, heightPx: 14);
  late final TextStyle caption        = _createFont(contentFont, sizePx: 14, heightPx: 20, weight: FontWeight.w500).copyWith(fontStyle: FontStyle.italic);
  late final TextStyle label          = _createFont(contentFont, sizePx: 14, heightPx: 20,  spacingPc: 2);

  TextStyle _createFont(TextStyle style, {required double sizePx, double? heightPx, double? spacingPc, FontWeight? weight}) {
    final scaledSizePx    = sizePx * _scale;
    final scaledHeightPx  = heightPx != null ? heightPx * _scale : null;
    final letterSpacing   = spacingPc != null ? scaledSizePx * spacingPc * 0.01 : style.letterSpacing;

    return style.copyWith(
      fontSize: scaledSizePx,
      height: scaledHeightPx != null ? scaledHeightPx / scaledSizePx : style.height,
      letterSpacing: letterSpacing,
      fontWeight: weight,
    );
  }
}

@immutable
class _Times {
  final Duration fast           = const Duration(milliseconds: 300);
  final Duration medium         = const Duration(milliseconds: 600);
  final Duration slow           = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double sm = 4;
  late final double md = 8;
  late final double lg = 32;
}

@immutable
class _Insets {
  _Insets(this._scale);
  final double _scale;

  late final double xxs     = 4 * _scale;
  late final double xs      = 8 * _scale;
  late final double sm      = 16 * _scale;
  late final double md      = 24 * _scale;
  late final double lg      = 32 * _scale;
  late final double xl      = 48 * _scale;
  late final double xxl     = 56 * _scale;
  late final double offset  = 80 * _scale;
}
