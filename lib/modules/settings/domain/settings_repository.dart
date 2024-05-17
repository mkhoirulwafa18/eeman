import 'package:quran_app/common/common.dart';

abstract class SettingsRepository {
  Future<UserPreferences> getPreferences();
  Future<void> setPreferences(UserPreferences newPreferences);
}
