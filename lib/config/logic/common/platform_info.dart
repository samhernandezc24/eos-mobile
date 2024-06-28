import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:flutter/foundation.dart';

class PlatformInfo {
  static const List<TargetPlatform> _desktopPlatforms  = <TargetPlatform>[ TargetPlatform.macOS, TargetPlatform.windows, TargetPlatform.linux ];
  static const List<TargetPlatform> _mobilePlatforms   = <TargetPlatform>[ TargetPlatform.android, TargetPlatform.iOS ];

  static bool get isDesktop       => _desktopPlatforms.contains(defaultTargetPlatform) && !kIsWeb;
  static bool get isDesktopOrWeb  => isDesktop || kIsWeb;
  static bool get isMobile        => _mobilePlatforms.contains(defaultTargetPlatform) && !kIsWeb;

  static bool get isWindows       => defaultTargetPlatform == TargetPlatform.windows;
  static bool get isLinux         => defaultTargetPlatform == TargetPlatform.linux;
  static bool get isMacOS         => defaultTargetPlatform == TargetPlatform.macOS;
  static bool get isAndroid       => defaultTargetPlatform == TargetPlatform.android;
  static bool get isIOS           => defaultTargetPlatform == TargetPlatform.iOS;

  static double get pixelRatio    => WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
}
