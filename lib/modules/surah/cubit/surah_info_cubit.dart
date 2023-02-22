import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_app/modules/surah_list/models/quran.dart';

part 'surah_info_state.dart';

class SurahInfoCubit extends Cubit<SurahInfoState> {
  SurahInfoCubit()
      : super(
          SurahInfoInitial(
            ayatSurah: const [],
            tafsirSurah: Tafsir(),
            lastReadAyat: 0,
            numberSurah: 0,
            revelation: Type.MAKKIYAH,
            title: '',
            totalAyat: 0,
            translation: '',
          ),
        );

  void init(int noSurah, List<Quran> dataQuran) {
    emit(
      SurahInfoLoaded(
        ayatSurah: dataQuran[noSurah].verses ?? [],
        tafsirSurah: dataQuran[noSurah].tafsir ?? Tafsir(),
        title: dataQuran[noSurah].name ?? '',
        numberSurah: dataQuran[noSurah].numberOfSurah ?? 0,
        translation: dataQuran[noSurah].nameTranslations!.id ?? '',
        revelation: dataQuran[noSurah].type ?? Type.MAKKIYAH,
        totalAyat: dataQuran[noSurah].numberOfAyah ?? 0,
        lastReadAyat: 0,
      ),
    );
  }
}
