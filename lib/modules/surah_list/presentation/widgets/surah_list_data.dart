// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:quran_app/gen/fonts.gen.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:quran_app/modules/surah_list/presentation/widgets/surah_list_tile.dart';

class SurahListData extends StatelessWidget {
  const SurahListData({
    super.key,
    required this.surahList,
    this.searchResult,
  });

  final List<Surah> surahList;
  final List<Surah>? searchResult;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final surahs = searchResult ?? surahList;
    return Expanded(
      child: surahs.isNotEmpty
          ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: surahs.length,
              separatorBuilder: (_, i) => Divider(
                color: colorScheme.onSurface,
              ),
              itemBuilder: (BuildContext context, int index) {
                return SurahListTile(
                  context: context,
                  index: index,
                  surahList: surahList,
                  resultSurah: surahs,
                );
              },
            )
          : Expanded(
              child: Center(
                child: Text(
                  l10n.errorNoSurahFound,
                  style: TextStyle(
                    fontFamily: FontFamily.poppins,
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
