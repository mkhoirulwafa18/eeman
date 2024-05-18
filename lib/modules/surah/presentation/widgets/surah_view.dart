// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/common/widgets/base_page.dart';
import 'package:quran_app/common/widgets/custom_app_bar.dart';
import 'package:quran_app/common/widgets/spacing.dart';
import 'package:quran_app/modules/settings/presentation/blocs/cubit/settings_cubit.dart';
import 'package:quran_app/modules/settings/presentation/blocs/state/settings_state.dart';
import 'package:quran_app/modules/surah/data/domain/verse_model.dart';
import 'package:quran_app/modules/surah/presentation/blocs/cubit/last_read_cubit.dart';
import 'package:quran_app/modules/surah/presentation/blocs/cubit/surah_cubit.dart';
import 'package:quran_app/modules/surah/presentation/blocs/state/last_read_state.dart';
import 'package:quran_app/modules/surah/presentation/widgets/action_button.dart';
import 'package:quran_app/modules/surah/presentation/widgets/surah_info.dart';
import 'package:quran_app/modules/surah/utils/dialog_preferences.dart';
import 'package:quran_app/modules/surah/utils/dialog_search_ayah.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:quran_app/modules/surah_list/presentation/widgets/rub_el_hizb.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahView extends StatefulWidget {
  const SurahView({
    super.key,
    required this.selectedSurah,
    required this.surahList,
    required this.controller,
    this.lastReadAyah,
  });

  final Surah selectedSurah;
  final List<Surah> surahList;
  final Verse? lastReadAyah;
  final ItemScrollController controller;

  @override
  State<SurahView> createState() => _SurahViewState();
}

class _SurahViewState extends State<SurahView> {
  final searchAyahController = TextEditingController();

  @override
  void dispose() {
    searchAyahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahCubit, SurahState>(
      builder: (context, state) {
        if (state is SurahInitial || state is SurahLoading) {
          return const AppLoading();
        } else if (state is SurahLoaded) {
          return BasePage.noPadding(
            accentBackground: false,
            appBar: CustomAppBar(
              title: widget.selectedSurah.name?.transliteration?.id ?? '',
              actions: [
                IconButton(
                  onPressed: () {
                    // ignore: inference_failure_on_function_invocation
                    showSearchAyahDialog(
                      context,
                      searchAyahController,
                      widget.controller,
                      widget.selectedSurah.numberOfVerses ?? 0,
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: backgroundColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // ignore: inference_failure_on_function_invocation
                    showPreferencesDialog(
                      context,
                      searchAyahController,
                      widget.selectedSurah.numberOfVerses ?? 0,
                    );
                  },
                  icon: Icon(
                    Icons.settings,
                    color: backgroundColor,
                  ),
                ),
              ],
            ),
            child: state.verses.isNotEmpty
                ? BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, settingState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ScrollablePositionedList.builder(
                          physics: const BouncingScrollPhysics(),
                          itemScrollController: widget.controller,
                          shrinkWrap: true,
                          itemPositionsListener: ItemPositionsListener.create(),
                          itemCount: state.verses.length + 2,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: SurahInfo(surah: widget.selectedSurah),
                              );
                            }
                            index -= 1;
                            return widget.selectedSurah.numberOfVerses != index
                                ? _buildItem(context, index, state)
                                : _buildFooter(widget.selectedSurah, widget.surahList);
                          },
                        ),
                      );
                    },
                  )
                : const AppLoading(),
          );
        } else if (state is SurahError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Unexpected Error'),
          );
        }
      },
    );
  }

  Padding _buildFooter(Surah surah, List<Surah> surahList) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (surah.number != 1)
            ActionButton(
              type: ButtonActionType.back,
              surahList: surahList,
              selectedSurah: surah,
            )
          else
            const SizedBox(),
          if (surah.number != 114)
            ActionButton(
              type: ButtonActionType.next,
              surahList: surahList,
              selectedSurah: surah,
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, SurahLoaded surah) {
    Future<void> setLastRead() async {
      await context.read<LastReadCubit>().setLastRead(context, surah.verses[index]);
    }

    final userPref = context.watch<SettingsCubit>().state.userPreferences;
    return Stack(
      children: [
        ListTile(
          onLongPress: setLastRead,
          dense: true,
          contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          tileColor: index.isEven ? backgroundColor : backgroundColor.withAlpha(200),
          title: RichText(
            textAlign: TextAlign.justify,
            textDirection: TextDirection.rtl,
            text: TextSpan(
              children: [
                TextSpan(
                  text: surah.verses[index].ayahText,
                  style: arabicText.copyWith(fontSize: userPref?.arabicFontSize),
                ),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: RubElHizb(
                      number: (index + 1).toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          isThreeLine: (userPref?.showLatin != null || userPref?.showTranslation != null)
              ? ((userPref?.showLatin ?? false) || (userPref!.showTranslation ?? false) ? true : false)
              : false,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: (userPref?.showLatin ?? false || (userPref?.showTranslation ?? false)) ? true : false,
                child: const EemanSpacing.vertical16(),
              ),
              Visibility(
                visible: userPref?.showLatin ?? true,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: surah.verses[index].readText,
                        style: TextStyle(
                          color: backgroundColor2,
                          fontSize: userPref?.latinFontSize,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const EemanSpacing.vertical8(),
              Visibility(
                visible: userPref?.showTranslation ?? true,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: surah.verses[index].indoText,
                        style: smallText.copyWith(color: backgroundColor2, fontSize: userPref?.translationFontSize),
                      ),

                      /// Remove Tafsir for v2.0.0
                      // WidgetSpan(
                      //   child: GestureDetector(
                      //     // onTap: () => showTafsirBottomSheet(context, surah, index),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 5),
                      //       child: Icon(
                      //         Icons.info,
                      //         size: 15,
                      //         color: backgroundColor2.withOpacity(.5),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<LastReadCubit, LastReadState>(
          builder: (context, lastRead) {
            bool isLastRead;
            if (lastRead is LastReadLoaded) {
              isLastRead = lastRead.verse.suraId == surah.verses[0].suraId && lastRead.verse.verseId == index + 1;
            } else {
              isLastRead = false;
            }
            return GestureDetector(
              onTap: setLastRead,
              child: Icon(
                isLastRead ? Icons.book_rounded : Icons.book_outlined,
                color: isLastRead ? backgroundColor2 : backgroundColor2.withOpacity(.3),
              ),
            );
          },
        ),
      ],
    );
  }
}
