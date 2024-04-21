import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/services/preferences.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/common/widgets/base_page.dart';
import 'package:quran_app/common/widgets/custom_app_bar.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/widgets/input_box.dart';
import 'package:quran_app/modules/surah_list/presentation/blocs/cubit/surah_list_cubit.dart';
import 'package:quran_app/modules/surah_list/presentation/blocs/state/surah_list_state.dart';
import 'package:quran_app/modules/surah_list/presentation/widgets/surah_list_data.dart';

class SurahListView extends StatelessWidget {
  const SurahListView({super.key});

  // void goToSurah({int? noSurah, bool? startScroll}) {
  MaterialBanner _showMaterialBanner(BuildContext context) {
    return MaterialBanner(
      content: Text(
        context.l10n.lastReadError,
        style: smallText,
      ),
      backgroundColor: backgroundColor2,
      actions: [
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
            // goToSurah(noSurah: 0, startScroll: false);
          },
          child: Text(
            context.l10n.alFatiha,
            style: smallText.copyWith(color: backgroundColor2),
          ),
        ),
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: Text(
            context.l10n.close,
            style: smallText.copyWith(color: backgroundColor2),
          ),
        ),
      ],
    );
  }

  // TODO(mkhoirulwafa18): redesign local data system
  Future<void> navigateToLastRead(BuildContext context) async {
    final preferences = await Preferences.getInstance();
    final numberSurah = preferences.getLastSurahRead();
    if (numberSurah == 0) {
      ScaffoldMessenger.of(context)
        ..removeCurrentMaterialBanner()
        ..showMaterialBanner(_showMaterialBanner(context));
    } else {
      // goToSurah(noSurah: numberSurah - 1, startScroll: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
                  log('ini adalah keywordnya : $key');
                  context.read<SurahListCubit>().onSearch(key);
                },
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: backgroundColor2,
              onPressed: () => navigateToLastRead(context),
              icon: SvgPicture.asset(
                '$iconAsset/last_read.svg',
                width: 30,
              ),
              label: Text(
                l10n.lastRead,
                style: smallText,
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
