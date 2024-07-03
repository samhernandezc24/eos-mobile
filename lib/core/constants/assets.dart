/// Unifica las rutas de las imágenes utilizadas en la aplicación.
class ImagePaths {
  // ROOT
  static const String _root             = 'assets/images';
  static const String _backgrounds      = '$_root/backgrounds';
  static const String _logo             = '$_root/logo';

  // BACKGROUNDS
  static const String background001     = '$_backgrounds/background-001.jpg';

  // ERRORS
  static const String errors            = '$_root/errors';

  // LOGO
  static const String appLogo           = '$_logo/app-logo.png';

  // PAGES
  static const String pages             = '$_root/pages';

  // WELCOME (ON-BOARDING PAGE)
  static const String welcome           = '$_root/welcome';
}

/// Unifica las rutas de las imágenes SVG en su propia clase,
/// indica a la UI para usar un SvgPicture a renderizar.
class SvgPaths {
  static const String error404        = '${ImagePaths.errors}/404.svg';
  static const String error500        = '${ImagePaths.errors}/500.svg';
  static const String forgotPassword  = '${ImagePaths.pages}/forgot_password.svg';
}

/// Unifica las rutas de los lotties en su propia clase.
class LottiePaths {
  static const String _root                = 'assets/lottie';
  static const String underConstruction     = '$_root/page_under_construction.json';
}
