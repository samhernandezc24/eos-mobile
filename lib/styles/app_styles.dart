import 'package:eos_mobile/shared/shared.dart';

class AppStyle {
  AppStyle({Size? screenSize}) {
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

  /// Rounded edge corner radii
  late final _Corners corners = _Corners();

  /// Padding and margin values
  late final _Insets insets = _Insets(scale);

  /// Text styles
  late final _Text text = _Text(scale);
}

@immutable
class _Text {
  _Text(this._scale);

  final double _scale;

  final TextStyle _titleFonts   = const TextStyle(fontFamily: 'Quicksand');
  final TextStyle _contentFonts = const TextStyle(fontFamily: 'OpenSans');

  TextStyle get titleFont => _titleFonts;
  TextStyle get contentFont => _contentFonts;

  late final TextStyle h1 = _createFont(titleFont, sizePx: 64, heightPx: 62);
  late final TextStyle h2 = _createFont(titleFont, sizePx: 32, heightPx: 46);
  late final TextStyle h3 = _createFont(titleFont, sizePx: 24, heightPx: 36, weight: FontWeight.w600);
  late final TextStyle h4 = _createFont(contentFont, sizePx: 14, heightPx: 23, spacingPc: 5, weight: FontWeight.w600);

  late final TextStyle title1 = _createFont(titleFont, sizePx: 16, heightPx: 26, spacingPc: 5);

  TextStyle _createFont(
    TextStyle style, {
    required double sizePx,
    double? heightPx,
    double? spacingPc,
    FontWeight? weight,
  }) {
    sizePx *= _scale;

    if (heightPx != null) {
      heightPx *= _scale;
    }

    return style.copyWith(
      fontSize: sizePx,
      height: heightPx != null ? (heightPx / sizePx) : style.height,
      letterSpacing: spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
      fontWeight: weight,
    );
  }
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
