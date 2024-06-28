part of 'local_settings_bloc.dart';

sealed class LocalSettingsEvent extends Equatable {
  const LocalSettingsEvent();

  @override
  List<Object?> get props => [];
}

/// [GetThemeModeUseCase]
class GetThemeMode extends LocalSettingsEvent {}

/// [SetThemeModeUseCase]
class SetThemeMode extends LocalSettingsEvent {
  const SetThemeMode(this.isDarkModeEnabled);

  final bool isDarkModeEnabled;

  @override
  List<Object?> get props => [ isDarkModeEnabled ];
}
