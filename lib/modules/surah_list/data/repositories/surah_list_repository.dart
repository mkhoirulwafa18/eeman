// ignore_for_file: one_member_abstracts

import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';

abstract class SurahListRepository {
  Future<List<Surah>> getSurahList();
}
