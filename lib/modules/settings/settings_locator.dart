import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/modules/settings/data/settings_repository_impl.dart';
import 'package:quran_app/modules/settings/domain/settings_usecase.dart';

void setupLocatorSettings() {
  // *Repository
  locator
    ..registerLazySingleton(SettingsRepositoryImpl.new)
    // *UseCase
    ..registerLazySingleton(() => SettingsUseCaseImpl(locator<SettingsRepositoryImpl>()));
}
