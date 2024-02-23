import 'dart:io';

import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/foundation.dart';

class HapticsUtils {
  // nota: los sonidos del sistema tienen bastantes fallos en
  // Android: https://github.com/flutter/flutter/issues/57531
  static bool debugSound      = kDebugMode;
  static bool debugLog        = kDebugMode;
  static bool enableDebugLogs = false;

  static void onButtonPressed() {
    if (Platform.isAndroid) {
      lightImpact();
    }
  }

  static Future<void> lightImpact() {
    _debug('lightImpact');
    return HapticFeedback.lightImpact();
  }

  static Future<void> mediumImpact() {
    _debug('mediumImpact');
    return HapticFeedback.mediumImpact();
  }

  static Future<void> heavyImpact() {
    _debug('heavyImpact');
    return HapticFeedback.heavyImpact();
  }

  static Future<void> selectionClick() {
    _debug('selectionClick');
    return HapticFeedback.selectionClick();
  }

  static Future<void> vibrate() {
    _debug('vibrate');
    return HapticFeedback.vibrate();
  }

  static void _debug(String label) {
    if (debugLog) debugPrint('Haptic.$label');
    if (debugSound) {
      SystemSound.play(SystemSoundType.click);
    }
  }
}
