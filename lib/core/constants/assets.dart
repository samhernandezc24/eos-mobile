/// Unifica las rutas de las imágenes utilizadas en la aplicación.
class ImagePaths {
  static const String root            = 'assets/images';
  static const String backgrounds     = '$root/backgrounds';
  static const String errors          = '$root/errors';
  static const String pages           = '$root/pages';
  static const String welcome         = '$root/welcome';

  static const String appLogo         = '$root/logo/app-logo.png';

  static const String crane           = '$root/pages/crane.png';
  static const String circleVehicle   = '$root/pages/circle_vehicle_config.png';

  static const String background001   = '$backgrounds/background-001.jpg';

  // static const String iconCrane     = '$root/icons/crane.png';
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
  static const String root                = 'assets/lottie';
  static const String underConstruction   = '$root/page_under_construction.json';
}
