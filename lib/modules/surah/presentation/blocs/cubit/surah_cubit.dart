import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_app/modules/surah/data/domain/verse_model.dart';
import 'package:quran_app/modules/surah/domain/surah_usecase.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part '../state/surah_state.dart';

class SurahCubit extends Cubit<SurahState> {
  SurahCubit(this._surahUseCase) : super(const SurahInitial());

  final SurahUseCase _surahUseCase;

  // Future<void> goToLastRead(
  //   int noSurah,
  //   List dataQuran,
  //   ItemScrollController controller,
  // ) async {
  //   final preferences = await Preferences.getInstance();
  //   final lastAyah = preferences.getLastAyahRead();

  //   if (await isLastSurah(noSurah, dataQuran)) {
  //     SchedulerBinding.instance.addPostFrameCallback((_) async {
  //       if (controller.isAttached) {
  //         await controller.scrollTo(
  //           index: lastAyah,
  //           duration: const Duration(seconds: 1),
  //           curve: Curves.elasticIn,
  //         );
  //       }
  //     });
  //   }
  // }

  // void setLastRead(SurahLoaded state, int surah, int ayah) {
  //   emit(
  //     SurahLoaded(
  //       ayatSurah: state.ayatSurah,
  //       tafsirSurah: state.tafsirSurah,
  //       title: state.title,
  //       numberSurah: state.numberSurah,
  //       translation: state.translation,
  //       revelation: state.revelation,
  //       totalAyat: state.totalAyat,
  //       indexLastSurah: surah,
  //       indexLastAyah: ayah,
  //     ),
  //   );
  // }

  // Future<bool> isLastSurah(int noSurah, List dataQuran) async {
  //   final preferences = await Preferences.getInstance();
  //   final lastSurah = preferences.getLastSurahRead();
  //   return lastSurah == dataQuran[noSurah].numberOfSurah;
  // }

  Future<void> init({
    int noSurah = 0,
    List<Surah> surahList = const <Surah>[],
    // ignore: avoid_positional_boolean_parameters
    bool startScroll = false,
    ItemScrollController? controller,
  }) async {
    final verses = await _surahUseCase.getVersesBySura(noSurah);
    if (verses.isNotEmpty) {
      emit(SurahLoaded(verses: verses, surahs: surahList));
    } else {
      emit(const SurahError('Surah is Empty / Not Found'));
    }
    // if (startScroll) {
    //   await goToLastRead(noSurah, dataQuran, controller!);
    // }
  }
}
