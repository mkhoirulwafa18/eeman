import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/scheduler.dart';
import 'package:quran_app/modules/surah/data/domain/verse_model.dart';
import 'package:quran_app/modules/surah/domain/surah_usecase.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part '../state/surah_state.dart';

class SurahCubit extends Cubit<SurahState> {
  SurahCubit(this._surahUseCase) : super(const SurahInitial());

  final SurahUseCase _surahUseCase;

  Future<void> scrollToLastRead(
    Verse ayah,
    ItemScrollController controller,
  ) async {
    // final preferences = await Preferences.getInstance();
    // final lastAyah = preferences.getLastAyahRead();

    // if (await isLastSurah(noSurah, dataQuran)) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (controller.isAttached) {
        await controller.scrollTo(
          index: ayah.verseId,
          duration: const Duration(seconds: 1),
          curve: Curves.elasticIn,
          alignment: .2,
        );
      }
    });
    // }
  }

  Future<void> init({
    int noSurah = 0,
    List<Surah> surahList = const <Surah>[],
    // ignore: avoid_positional_boolean_parameters
    Verse? lastReadAyah,
    ItemScrollController? controller,
  }) async {
    final verses = await _surahUseCase.getVersesBySura(noSurah);
    if (verses.isNotEmpty) {
      emit(SurahLoaded(verses: verses, surahs: surahList));
    } else {
      emit(const SurahError('Surah is Empty / Not Found'));
    }
    if (lastReadAyah != null) {
      await scrollToLastRead(lastReadAyah, controller!);
    }
  }
}
