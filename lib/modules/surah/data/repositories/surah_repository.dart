// ignore_for_file: one_member_abstracts

import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/common/services/database_helper.dart';
import 'package:quran_app/modules/surah/data/domain/verse_model.dart';

abstract class SurahRepository {
  Future<List<Verse>> getVersesBySura(int sura);
}

class SurahRepositoryImpl extends SurahRepository {
  SurahRepositoryImpl() {
    databaseHelper = locator<DatabaseHelper>(param1: 'al-quran-indopak.db');
  }
  late DatabaseHelper databaseHelper;

  @override
  Future<List<Verse>> getVersesBySura(int sura) async {
    final dbVerses = await databaseHelper.getVersesBySura(sura);
    final verses = dbVerses.map(Verse.fromMap).toList();
    return verses;
  }
}
