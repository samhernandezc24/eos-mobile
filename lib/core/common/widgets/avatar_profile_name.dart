import 'package:eos_mobile/shared/shared_libraries.dart';

class AvatarProfileName extends StatelessWidget {
  const AvatarProfileName({
    super.key,
    this.child,
    this.backgroundColor,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.foregroundColor,
    this.radius,
    this.minRadius,
    this.maxRadius,
  })  : assert(
          radius == null || (minRadius == null && maxRadius == null),
          'El radio debe ser nulo o tanto minRadius como maxRadius deben ser nulos',
        ),
        assert(
          backgroundImage != null || onBackgroundImageError == null,
          'Se debe proporcionar backgroundImage o onBackgroundImageError debe ser null',
        ),
        assert(
          foregroundImage != null || onForegroundImageError == null,
          'Se debe proporcionar foregroundImage o onForegroundImageError debe ser null',
        );

  final Widget? child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final ImageProvider? backgroundImage;
  final ImageProvider? foregroundImage;
  final ImageErrorListener? onBackgroundImageError;
  final ImageErrorListener? onForegroundImageError;
  final double? radius;
  final double? minRadius;
  final double? maxRadius;

  static const double _defaultRadius      = 20;
  static const double _defaultMinRadius   = 0;
  static const double _defaultMaxRadius   = double.infinity;

  double get _minDiameter {
    if (radius == null && minRadius == null && maxRadius == null) {
      return _defaultRadius * 2.0;
    }
    return 2.0 * (radius ?? minRadius ?? _defaultMinRadius);
  }

  double get _maxDiameter {
    if (radius == null && minRadius == null && maxRadius == null) {
      return _defaultRadius * 2.0;
    }
    return 2.0 * (radius ?? maxRadius ?? _defaultMaxRadius);
  }

  @override
  Widget build(BuildContext context) {
    assert(
      debugCheckHasMediaQuery(context),
      'No MediaQuery found.\nAsegúrese de que el árbol de widgets contenga un widget MediaQuery.',
    );

    final ThemeData theme = Theme.of(context);
    final Color? effectiveForegroundColor = foregroundColor ??
        (theme.useMaterial3 ? theme.colorScheme.onPrimaryContainer : null);
    final TextStyle effectiveTextStyle = theme.useMaterial3
        ? theme.textTheme.titleMedium!
        : theme.primaryTextTheme.titleMedium!;

    TextStyle textStyle =
        effectiveTextStyle.copyWith(color: effectiveForegroundColor);
    Color? effectiveBackgroundColor = backgroundColor ??
        (theme.useMaterial3 ? theme.colorScheme.primaryContainer : null);

    if (effectiveBackgroundColor == null) {
      switch (ThemeData.estimateBrightnessForColor(textStyle.color!)) {
        case Brightness.dark:
          effectiveBackgroundColor = theme.primaryColorLight;
        case Brightness.light:
          effectiveBackgroundColor = theme.primaryColorDark;
      }
    } else if (effectiveForegroundColor == null) {
      switch (ThemeData.estimateBrightnessForColor(backgroundColor!)) {
        case Brightness.dark:
          textStyle = textStyle.copyWith(color: theme.primaryColorLight);
        case Brightness.light:
          textStyle = textStyle.copyWith(color: theme.primaryColorDark);
      }
    }

    final double minDiameter = _minDiameter;
    final double maxDiameter = _maxDiameter;

    return AnimatedContainer(
      constraints: BoxConstraints(
        minHeight: minDiameter,
        minWidth: minDiameter,
        maxWidth: maxDiameter,
        maxHeight: maxDiameter,
      ),
      duration: kThemeChangeDuration,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        image: backgroundImage != null
            ? DecorationImage(
                image: backgroundImage!,
                onError: onBackgroundImageError,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              )
            : null,
        shape: BoxShape.circle,
      ),
      foregroundDecoration: foregroundImage != null
          ? BoxDecoration(
              image: DecorationImage(
                image: foregroundImage!,
                onError: onForegroundImageError,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
              shape: BoxShape.circle,
            )
          : null,
      child: child == null
          ? null
          : Center(
              // Necesitamos desactivar el escalado de texto aquí para que el texto no
              // escape del avatar cuando el textScaleFactor sea grande.
              child: MediaQuery.withNoTextScaling(
                child: IconTheme(
                  data: theme.iconTheme.copyWith(color: textStyle.color),
                  child: DefaultTextStyle(
                    style: textStyle,
                    child: child!,
                  ),
                ),
              ),
            ),
    );
  }
}
