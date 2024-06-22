import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/gen/assets.gen.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/surah/data/domain/verse_model.dart';
import 'package:quran_app/modules/surah/presentation/surah_page.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:quran_app/modules/surah_list/presentation/blocs/cubit/surah_list_cubit.dart';
import 'package:quran_app/modules/surah_list/presentation/blocs/state/surah_list_state.dart';
import 'package:quran_app/modules/surah_list/presentation/widgets/surah_list_data.dart';

class SurahListView extends StatelessWidget {
  const SurahListView({super.key});

  MaterialBanner _showMaterialBanner(BuildContext context, List<Surah> surahList) {
    final colorScheme = Theme.of(context).colorScheme;
    return MaterialBanner(
      content: Text(
        context.l10n.lastReadError,
        style: context.bodySmall,
      ),
      backgroundColor: colorScheme.primary,
      actions: [
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(colorScheme.secondary),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
            Navigator.push<MaterialPageRoute<dynamic>>(
              context,
              MaterialPageRoute(
                builder: (context) => SurahPage(
                  selectedSurah: surahList[0],
                  surahList: surahList,
                ),
              ),
            );
          },
          child: Text(
            context.l10n.alFatiha,
            style: context.bodySmall?.copyWith(color: colorScheme.primary),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: Text(
            context.l10n.close,
            style: context.bodySmall?.copyWith(color: colorScheme.secondary),
          ),
        ),
      ],
    );
  }

  Future<void> navigateToLastRead(BuildContext context, List<Surah> surahList) async {
    final stringData = await locator<LastReadAyahLocalData>().getValue();

    if (stringData != null) {
      final ayah = Verse.fromMap(jsonDecode(stringData) as Map<String, dynamic>);
      await Navigator.push<MaterialPageRoute<dynamic>>(
        context,
        MaterialPageRoute(
          builder: (context) => SurahPage(
            selectedSurah: surahList[ayah.suraId - 1],
            surahList: surahList,
            lastReadAyah: ayah,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentMaterialBanner()
        ..showMaterialBanner(_showMaterialBanner(context, surahList));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<SurahListCubit, SurahListState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BasePage(
            appBar: CustomAppBar(
              onBackTapped: () {
                ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                Navigator.of(context).pop();
              },
              height: MediaQuery.of(context).size.height / 5.5,
              title: l10n.surahListPageAppBarTitle,
              content: InputBox(
                labelText: l10n.findSurah,
                onChanged: (key) {
                  context.read<SurahListCubit>().onSearch(key);
                },
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: colorScheme.onBackground,
              onPressed: () => state is SurahListLoaded ? navigateToLastRead(context, state.surahList) : null,
              icon: Assets.icons.lastRead.svg(width: 30),
              label: Text(
                l10n.lastRead,
                style: context.bodySmall?.copyWith(color: colorScheme.background),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is SurahListLoaded)
                  SurahListData(surahList: state.surahList, searchResult: state.searchResult)
                else
                  const AppLoading(),
              ],
            ),
          ),
        );
      },
    );
  }
}
