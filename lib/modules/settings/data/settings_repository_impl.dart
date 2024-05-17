import 'dart:convert';

import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/modules/settings/domain/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  @override
  Future<UserPreferences> getPreferences() async {
    final localData = locator<PreferencesLocalData>();
    final stringData = await localData.getValue();
    if (stringData != null) {
      return UserPreferences.fromJson(jsonDecode(stringData) as Map<String, dynamic>);
    } else {
      return const UserPreferences();
    }
  }

  @override
  Future<void> setPreferences(UserPreferences newPreferences) async {
    final localData = locator<PreferencesLocalData>();
    await localData.setValue(jsonEncode(newPreferences.toJson()));
  }
}
