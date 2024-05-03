// ignore_for_file: one_member_abstracts

import 'package:flutter/services.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:quran_app/modules/surah_list/data/repositories/surah_list_repository.dart';

class SurahListRepositoryImpl implements SurahListRepository {
  SurahListRepositoryImpl();

  @override
  Future<List<Surah>> getSurahList() async {
    final response = await rootBundle.loadString('assets/sources/surah.json');

    if (response.isNotEmpty) {
      return surahFromJson(response);
    } else {
      return [];
    }
  }
}
