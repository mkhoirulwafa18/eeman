// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/modules/surah/data/domain/verse_model.dart';
import 'package:quran_app/modules/surah/domain/surah_usecase.dart';
import 'package:quran_app/modules/surah/presentation/blocs/cubit/last_read_cubit.dart';
import 'package:quran_app/modules/surah/presentation/blocs/cubit/surah_cubit.dart';
import 'package:quran_app/modules/surah/presentation/widgets/surah_view.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahPage extends StatelessWidget {
  SurahPage({super.key, required this.selectedSurah, required this.surahList, this.lastReadAyah});

  /// We need [surahList] as well to fulfill the requirement of user can navigate to the next and previous surah,
  /// so we need the list of the surah and the current [selectedSurah]
  final Surah selectedSurah;
  final List<Surah> surahList;
  final Verse? lastReadAyah;
  final controller = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SurahCubit(locator<SurahUseCaseImpl>())
            ..init(
              noSurah: selectedSurah.number ?? 0,
              surahList: surahList,
              lastReadAyah: lastReadAyah,
              controller: controller,
            ),
        ),
        BlocProvider(create: (_) => LastReadCubit()),
      ],
      child: SurahView(
        selectedSurah: selectedSurah,
        surahList: surahList,
        lastReadAyah: lastReadAyah,
        controller: controller,
      ),
    );
  }
}
