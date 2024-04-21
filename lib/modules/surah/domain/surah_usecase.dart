// ignore_for_file: one_member_abstracts

import 'package:quran_app/modules/surah/data/domain/verse_model.dart';
import 'package:quran_app/modules/surah/data/repositories/surah_repository.dart';

abstract class SurahUseCase {
  Future<List<Verse>> getVersesBySura(int sura);
}

class SurahUseCaseImpl implements SurahUseCase {
  SurahUseCaseImpl(this._surahRepository);
  final SurahRepository _surahRepository;

  @override
  Future<List<Verse>> getVersesBySura(int sura) async {
    final list = await _surahRepository.getVersesBySura(sura);
    return list;
  }
}
