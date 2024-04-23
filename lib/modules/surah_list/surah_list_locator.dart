import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/modules/surah_list/data/repositories/surah_list_repository_impl.dart';
import 'package:quran_app/modules/surah_list/domain/surah_list_usecase.dart';

void setupLocatorSurahList() {
  // *Repository
  locator
    ..registerLazySingleton(SurahListRepositoryImpl.new)
    // *UseCase
    ..registerLazySingleton(() => SurahListUseCaseImpl(locator<SurahListRepositoryImpl>()));
}
