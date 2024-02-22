class ImagePaths {
  static const String root          = 'assets/images';
  static const String backgrounds   = '$root/backgrounds';
  static const String errors        = '$root/errors';
  static const String logo          = '$root/logo';
  static const String pages         = '$root/pages';

  static const String appLogo       = '$logo/app-logo.png';

  static const String background1   = '$backgrounds/background-001.jpg';
}

class SvgPaths {
  static const String error404  = '${ImagePaths.errors}/404.svg';
  static const String error500  = '${ImagePaths.errors}/500.svg';

  static const String forgotPassword = '${ImagePaths.pages}/forgot_password.svg';
}
