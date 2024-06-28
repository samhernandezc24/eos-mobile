import 'package:eos_mobile/features/settings/domain/repository/settings_repository.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class SetThemeModeUseCase implements UseCase<void, bool> {
  SetThemeModeUseCase(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  Future<void> call({required bool params}) {
    return _settingsRepository.setThemeMode(params);
  }
}
