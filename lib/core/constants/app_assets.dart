class AppAssets {
  AppAssets._();

  /// Consolida las rutas de imágenes rasterizadas utilizadas en
  /// toda la aplicación.
  static const String root    = 'assets/images';
  static const String errors  = 'assets/images/errors';
  static const String screens = 'assets/images/screens';
  static const String icons   = 'assets/icons';
  static const String lottie  = 'assets/lottie';

  static const String appLogo = '$root/logo/eos_mobile_logo.png';

  /// Consolida las rutas de imágenes SVG utilizadas en toda la aplicación.
  static const String error404 = '$errors/404.svg';
  static const String error500 = '$errors/500.svg';

  static const String forgotPassword = '$screens/forgot_password.svg';
}
