import 'package:quran_app/common/common.dart';

class SettingsState {
  const SettingsState({this.userPreferences = const UserPreferences()});
  final UserPreferences? userPreferences;

  SettingsState copyWith({UserPreferences? userPreferences}) =>
      SettingsState(userPreferences: userPreferences ?? this.userPreferences);
}
