// ignore_for_file: one_member_abstracts

import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:quran_app/modules/surah_list/data/repositories/surah_list_repository.dart';

abstract class SurahListUseCase {
  Future<List<Surah>> getSurahList();
}

class SurahListUseCaseImpl implements SurahListUseCase {
  SurahListUseCaseImpl(this._surahListRepository);
  final SurahListRepository _surahListRepository;

  @override
  Future<List<Surah>> getSurahList() async {
    final list = await _surahListRepository.getSurahList();
    return list;
  }
}
