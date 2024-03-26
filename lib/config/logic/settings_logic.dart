import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/config/logic/common/save_load_mixin.dart';
import 'package:eos_mobile/shared/shared.dart';

class SettingsLogic with ThrottledSaveLoadMixin {
  late final ValueNotifier<bool> hasCompletedOnboarding     = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final ValueNotifier<bool> isLoggedIn                 = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final ValueNotifier<bool> isDarkModeEnabled          = ValueNotifier<bool>(false)..addListener(scheduleSave);

  final bool useBlurs = !PlatformInfo.isAndroid;

  @override
  void copyFromJson(Map<String, dynamic> value) {
    hasCompletedOnboarding.value      = value['hasCompletedOnboarding'] as bool? ?? false;
    isLoggedIn.value                  = value['isLoggedIn']             as bool? ?? false;
    isDarkModeEnabled.value           = value['isDarkModeEnabled']      as bool? ?? false;
  }

  @override
  String get fileName => 'settings.dat';

  @override
  Map<String, dynamic> toJson() {
    return {
      'hasCompletedOnboarding'    : hasCompletedOnboarding.value,
      'isLoggedIn'                : isLoggedIn.value,
      'isDarkModeEnabled'         : isDarkModeEnabled.value,
    };
  }
}
