import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/config/logic/common/save_load_mixin.dart';
import 'package:eos_mobile/shared/shared.dart';

class SettingsLogic with ThrottledSaveLoadMixin {
  @override
  String get fileName => 'settings.dat';

  late final ValueNotifier<bool> hasCompletedOnboarding     = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final ValueNotifier<bool> hasAuthenticated           = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final ValueNotifier<bool> isDarkModeEnabled          = ValueNotifier<bool>(false)..addListener(scheduleSave);

  final bool useBlurs = !PlatformInfo.isAndroid;

  @override
  void copyFromJson(Map<String, dynamic> value) {
    hasCompletedOnboarding.value      = value['hasCompletedOnboarding'] as bool? ?? false;
    hasAuthenticated.value            = value['hasAuthenticated']       as bool? ?? false;
    isDarkModeEnabled.value           = value['isDarkModeEnabled']      as bool? ?? false;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hasCompletedOnboarding'    : hasCompletedOnboarding.value,
      'hasAuthenticated'          : hasAuthenticated.value,
      'isDarkModeEnabled'         : isDarkModeEnabled.value,
    };
  }
}
