import 'package:eos_mobile/shared/shared.dart';

@immutable
class AppStyles {
  AppStyles({Size? screenSize}) {
    // Escala de la aplicación basada en el tamaño de la pantalla.
    if (screenSize == null) {
      scale = 1;
      return;
    }

    // Determinar la escala basada en el tamaño mas pequeño de la pantalla.
    final double shortesSide  = screenSize.shortestSide;
    const int tabletXl        = 1000;
    const int tabletLg        = 800;

    if (shortesSide > tabletXl) {
      scale = 1.2;
    } else if (shortesSide > tabletLg) {
      scale = 1.1;
    } else {
      scale = 1;
    }
  }

  late final double scale;

  /// Clase para definir radios de esquina con bordes redondeados.
  late final _Corners corners         = _Corners();
  /// Clase para definir sombras en elementos.
  late final _Shadows shadow          = _Shadows();
  /// Clase para definir valores de padding y margin.
  late final _Insets insets           = _Insets(scale);
  /// Clase para definir estilos de texto.
  late final _TextStyles textStyles   = _TextStyles(scale);
  /// Clase para definir las velocidades de las animaciones y transiciones en la aplicación.
  final _Times times                  = _Times();
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
    final double scaledSizePx     = sizePx * _scale;
    final double? scaledHeightPx  = heightPx != null ? heightPx * _scale : null;
    final double? letterSpacing   = spacingPc != null ? scaledSizePx * spacingPc * 0.01 : style.letterSpacing;

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
  final Duration fastest          = const Duration(milliseconds: 150);
  final Duration fast             = const Duration(milliseconds: 250);
  final Duration medium           = const Duration(milliseconds: 350);
  final Duration slow             = const Duration(milliseconds: 700);
  final Duration pageTransition   = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double sm  = 4;
  late final double md  = 8;
  late final double lg  = 32;
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

@immutable
class _Shadows {
  final List<Shadow> textSoft = <Shadow>[
    Shadow(color: Colors.black.withOpacity(.25), offset: const Offset(0, 2), blurRadius: 4),
  ];

  final List<Shadow> text = <Shadow>[
    Shadow(color: Colors.black.withOpacity(.6), offset: const Offset(0, 2), blurRadius: 2),
  ];

  final List<Shadow> textStrong = <Shadow>[
    Shadow(color: Colors.black.withOpacity(.6), offset: const Offset(0, 4), blurRadius: 6),
  ];
}
