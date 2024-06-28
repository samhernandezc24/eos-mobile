import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/config/logic/common/save_load_mixin.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class SettingsLogic with ThrottledSaveLoadMixin {
  late final ValueNotifier<bool> hasCompletedOnboarding   = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final ValueNotifier<bool> hasAuthenticated         = ValueNotifier<bool>(false)..addListener(scheduleSave);

  final bool useBlurs = !PlatformInfo.isAndroid;

  @override
  void copyFromJson(Map<String, dynamic> value) {
    hasCompletedOnboarding.value  = value['hasCompletedOnboarding'] as bool? ?? false;
    hasAuthenticated.value        = value['hasAuthenticated'] as bool? ?? false;
  }

  @override
  String get fileName => 'settings.dat';

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'hasCompletedOnboarding'  : hasCompletedOnboarding.value,
      'hasAuthenticated'        : hasAuthenticated.value,
    };
  }
}
