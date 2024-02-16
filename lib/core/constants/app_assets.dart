class AppAssets {
  AppAssets._();

  /// Consolidates raster image paths used across the app.
  static const String root    = 'assets/images';
  static const String errors  = 'assets/images/errors';
  static const String icons   = 'assets/icons';
  static const String lottie  = 'assets/lottie';

  static const String appLogo = '$root/logo/eos_mobile_logo.png';

  /// Consolidates SVG image paths used across the app.
  static const String error404 = '$errors/404.svg';
  static const String error500 = '$errors/500.svg';
}
