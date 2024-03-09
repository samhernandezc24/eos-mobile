import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/foundation.dart';

class PlatformInfo {
  static const _desktopPlatforms  = [TargetPlatform.macOS, TargetPlatform.windows, TargetPlatform.linux];
  static const _mobilePlatforms   = [TargetPlatform.android, TargetPlatform.iOS];

  static bool get isDesktop       => _desktopPlatforms.contains(defaultTargetPlatform) && !kIsWeb;
  static bool get isDesktopOrWeb  => isDesktop || kIsWeb;

  static bool get isMobile        => _mobilePlatforms.contains(defaultTargetPlatform) && !kIsWeb;

  static double get pixelRatio    => WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  static bool get isWindows       => defaultTargetPlatform == TargetPlatform.windows;
  static bool get isLinux         => defaultTargetPlatform == TargetPlatform.linux;
  static bool get isMacOS         => defaultTargetPlatform == TargetPlatform.macOS;
  static bool get isAndroid       => defaultTargetPlatform == TargetPlatform.android;
  static bool get isIOS           => defaultTargetPlatform == TargetPlatform.iOS;

  static Future<bool> get isConnected async     =>  await Connectivity().checkConnectivity() != ConnectivityResult.none;
  static Future<bool> get isDisconnected async  =>  await Connectivity().checkConnectivity() == ConnectivityResult.none;
}
