import 'package:eos_mobile/shared/shared_libraries.dart';

class AppTheme {
  static ThemeData lightTheme(AppStyles styles) {
    return FlexThemeData.light(
      scheme: FlexScheme.blue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 10,
      subThemesData : const FlexSubThemesData(
        blendOnLevel                    : 10,
        blendOnColors                   : false,
        useTextTheme                    : true,
        useM2StyleDividerInM3           : true,
        alignedDropdown                 : true,
        useInputDecoratorThemeInDialogs : true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      useMaterial3ErrorColors: true,
      swapLegacyOnMaterial3: true,
      fontFamily: $styles.textStyles.body.fontFamily,
    );
  }

  static ThemeData darkTheme(AppStyles styles) {
    return FlexThemeData.dark(
      scheme: FlexScheme.blue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData : const FlexSubThemesData(
        blendOnLevel                    : 20,
        blendOnColors                   : false,
        useTextTheme                    : true,
        useM2StyleDividerInM3           : true,
        alignedDropdown                 : true,
        useInputDecoratorThemeInDialogs : true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      useMaterial3ErrorColors: true,
      swapLegacyOnMaterial3: true,
      fontFamily: $styles.textStyles.body.fontFamily,
    );
  }
}
