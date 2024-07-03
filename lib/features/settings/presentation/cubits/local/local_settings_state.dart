part of 'local_settings_cubit.dart';

class LocalSettingsState extends Equatable {
  const LocalSettingsState(this.themeData, this.isDark);

  final ThemeData themeData;
  final bool isDark;

  @override
  List<Object?> get props => [ themeData, isDark ];
}
