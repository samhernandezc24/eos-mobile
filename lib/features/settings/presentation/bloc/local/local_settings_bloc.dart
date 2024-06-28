import 'package:eos_mobile/features/settings/domain/usecases/get_theme_mode_usecase.dart';
import 'package:eos_mobile/features/settings/domain/usecases/set_theme_mode_usecase.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

part 'local_settings_event.dart';
part 'local_settings_state.dart';

class LocalSettingsBloc extends Bloc<LocalSettingsEvent, LocalSettingsState> {
  LocalSettingsBloc(
    this._getThemeModeUseCase,
    this._setThemeModeUseCase,
  ) : super(LocalSettingsInitial()) {
    on<GetThemeMode>(onGetThemeMode);
    on<SetThemeMode>(onSetThemeMode);
  }

  // CASOS DE USO
  final GetThemeModeUseCase _getThemeModeUseCase;
  final SetThemeModeUseCase _setThemeModeUseCase;

  Future<void> onGetThemeMode(GetThemeMode event, Emitter<LocalSettingsState> emit) async {
    final bool isDarkModeEnabled = await _getThemeModeUseCase(params: NoParams());
    emit(LocalSettingsGetThemeMode(isDarkModeEnabled));
  }

  Future<void> onSetThemeMode(SetThemeMode event, Emitter<LocalSettingsState> emit) async {
    await _setThemeModeUseCase(params: event.isDarkModeEnabled);
    emit(LocalSettingsSetThemeMode());
  }
}
