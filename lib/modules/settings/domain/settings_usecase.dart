import 'package:quran_app/common/common.dart';
import 'package:quran_app/modules/settings/domain/settings_repository.dart';

abstract class SettingsUseCase {
  Future<UserPreferences> getPreferences();
  Future<void> setPreferences(UserPreferences newPreferences);
}

// * Implementation of the SettingsUseCase
class SettingsUseCaseImpl implements SettingsUseCase {
  SettingsUseCaseImpl(this._settingsRepository);
  final SettingsRepository _settingsRepository;

  /// ---------------------------------
  /// Fecth [UserPreferences]
  /// ---------------------------------
  @override
  Future<UserPreferences> getPreferences() async {
    final pref = await _settingsRepository.getPreferences();
    return pref;
  }

  /// ---------------------------------
  /// Set [UserPreferences]
  /// ---------------------------------
  @override
  Future<void> setPreferences(UserPreferences newPreferences) async {
    await _settingsRepository.setPreferences(newPreferences);
  }
}
