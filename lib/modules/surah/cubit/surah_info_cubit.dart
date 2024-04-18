import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quran_app/common/services/preferences.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'surah_info_state.dart';

class SurahInfoCubit extends Cubit<SurahInfoState> {
  SurahInfoCubit()
      : super(
          SurahInfoInitial(
            ayatSurah: const [],
            tafsirSurah: Tafsir(),
            numberSurah: 0,
            revelation: Type,
            title: '',
            totalAyat: 0,
            translation: '',
            indexLastSurah: 0,
            indexLastAyah: 0,
          ),
        );

  Future<void> goToLastRead(
    int noSurah,
    List dataQuran,
    ItemScrollController controller,
  ) async {
    final preferences = await Preferences.getInstance();
    final lastAyah = preferences.getLastAyahRead();

    if (await isLastSurah(noSurah, dataQuran)) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        if (controller.isAttached) {
          await controller.scrollTo(
            index: lastAyah,
            duration: const Duration(seconds: 1),
            curve: Curves.elasticIn,
          );
        }
      });
    }
  }

  void setLastRead(SurahInfoLoaded state, int surah, int ayah) {
    emit(
      SurahInfoLoaded(
        ayatSurah: state.ayatSurah,
        tafsirSurah: state.tafsirSurah,
        title: state.title,
        numberSurah: state.numberSurah,
        translation: state.translation,
        revelation: state.revelation,
        totalAyat: state.totalAyat,
        indexLastSurah: surah,
        indexLastAyah: ayah,
      ),
    );
  }

  Future<bool> isLastSurah(int noSurah, List dataQuran) async {
    final preferences = await Preferences.getInstance();
    final lastSurah = preferences.getLastSurahRead();
    return lastSurah == dataQuran[noSurah].numberOfSurah;
  }

  // Future<void> init({
  //   int noSurah = 0,
  //   List<Quran> dataQuran = const [],
  //   // ignore: avoid_positional_boolean_parameters
  //   bool startScroll = false,
  //   ItemScrollController? controller,
  // }) async {
  //   final preferences = await Preferences.getInstance();
  //   emit(
  //     SurahInfoLoaded(
  //       ayatSurah: dataQuran[noSurah].verses ?? [],
  //       tafsirSurah: dataQuran[noSurah].tafsir ?? Tafsir(),
  //       title: dataQuran[noSurah].name ?? '',
  //       numberSurah: dataQuran[noSurah].numberOfSurah ?? 0,
  //       translation: dataQuran[noSurah].nameTranslations!.id ?? '',
  //       revelation: dataQuran[noSurah].type ?? Type,
  //       totalAyat: dataQuran[noSurah].numberOfAyah ?? 0,
  //       indexLastSurah: preferences.getLastSurahRead(),
  //       indexLastAyah: preferences.getLastAyahRead(),
  //     ),
  //   );
  //   if (startScroll) {
  //     await goToLastRead(noSurah, dataQuran, controller!);
  //   }
  // }
}
