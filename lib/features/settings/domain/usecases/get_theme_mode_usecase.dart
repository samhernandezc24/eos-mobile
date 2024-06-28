import 'package:eos_mobile/features/settings/domain/repository/settings_repository.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class GetThemeModeUseCase implements UseCase<bool, NoParams> {
  GetThemeModeUseCase(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  Future<bool> call({required NoParams params}) {
    return _settingsRepository.getThemeMode();
  }
}
