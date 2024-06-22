import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:quran_app/modules/surah_list/domain/surah_list_usecase.dart';
import 'package:quran_app/modules/surah_list/presentation/blocs/state/surah_list_state.dart';

class SurahListCubit extends Cubit<SurahListState> {
  SurahListCubit(this._surahListUseCase) : super(SurahListInitial()) {
    loadSurah();
  }

  final SurahListUseCase _surahListUseCase;

  late List<Surah> data;

  Future<void> loadSurah() async {
    try {
      data = await _surahListUseCase.getSurahList();
      emit(SurahListLoaded(surahList: data, searchResult: data));
    } catch (error) {
      emit(SurahListError(error.toString()));
    }
  }

  void onSearch(String key) {
    if (data.isNotEmpty) {
      final keyword = key.toLowerCase().replaceAll(RegExp("[^0-9a-zA-Z']"), '');
      late List<Surah> result;

      if (keyword == '') {
        result = data;
      } else {
        result = data
            .where(
              (element) => element.name!.transliteration!.id!
                  .toLowerCase()
                  .replaceAll(
                    RegExp("[^0-9a-zA-Z']"),
                    '',
                  )
                  .contains(keyword),
            )
            .toList();
      }
      emit(SurahListLoaded(surahList: data, searchResult: result));
    }
  }
}
