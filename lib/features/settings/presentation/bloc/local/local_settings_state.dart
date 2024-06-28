part of 'local_settings_bloc.dart';

class LocalSettingsState extends Equatable {
  const LocalSettingsState();

  @override
  List<Object?> get props => [];
}

/// SETTINGS INITIAL
class LocalSettingsInitial extends LocalSettingsState {}

/// GET THEME MODE
class LocalSettingsGetThemeMode extends LocalSettingsState {
  const LocalSettingsGetThemeMode(this.isDarkModeEnabled);

  final bool isDarkModeEnabled;

  @override
  List<Object?> get props => [ isDarkModeEnabled ];
}

/// SET THEME MODE
class LocalSettingsSetThemeMode extends LocalSettingsState {}
