import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/modules/settings/domain/settings_usecase.dart';
import 'package:quran_app/modules/settings/presentation/blocs/state/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsUseCase) : super(const SettingsState());

  final SettingsUseCase _settingsUseCase;

  Future<void> init() async {
    final userPref = await _settingsUseCase.getPreferences();
    emit(SettingsState(userPreferences: userPref));
  }

  Future<void> setPreferences(UserPreferences newPref) async {
    await _settingsUseCase.setPreferences(newPref);
    emit(state.copyWith(userPreferences: newPref));
  }
}
