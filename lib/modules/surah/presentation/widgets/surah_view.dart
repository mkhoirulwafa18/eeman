import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/common/widgets/base_page.dart';
import 'package:quran_app/common/widgets/custom_app_bar.dart';
import 'package:quran_app/modules/surah/presentation/blocs/cubit/surah_cubit.dart';
import 'package:quran_app/modules/surah/presentation/widgets/action_button.dart';
import 'package:quran_app/modules/surah/presentation/widgets/surah_info.dart';
import 'package:quran_app/modules/surah/utils/dialog_search_ayah.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:quran_app/modules/surah_list/presentation/widgets/rub_el_hizb.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quran_app/common/constants/constant.dart';
// import 'package:quran_app/common/services/preferences.dart';
// import 'package:quran_app/common/widgets/app_loading.dart';
// import 'package:quran_app/common/widgets/base_page.dart';
// import 'package:quran_app/common/widgets/custom_app_bar.dart';
// import 'package:quran_app/l10n/l10n.dart';
// import 'package:quran_app/modules/surah/cubit/murattal_cubit.dart';
// import 'package:quran_app/modules/surah/cubit/surah_info_cubit.dart';
// import 'package:quran_app/modules/surah/utils/dialog_search_ayah.dart';
// import 'package:quran_app/modules/surah/utils/tafsir_bottomsheet.dart';
// import 'package:quran_app/modules/surah/presentation/widgets/action_button.dart';
// import 'package:quran_app/modules/surah/presentation/widgets/surah_info.dart';
// import 'package:quran_app/modules/surah_list/presentation/widgets/rub_el_hizb.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// class SurahView extends StatelessWidget {
//   SurahView({
//     super.key,
//     required this.noSurah,
//     required this.dataQuran,
//     this.startScroll = false,
//   });
//   final int noSurah;
//   final List dataQuran;
//   final bool? startScroll;
//   final controller = ItemScrollController();
//   final searchAyahController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => MurattalCubit(),
//         ),
//         BlocProvider(
//           create: (context) => SurahInfoCubit()
//           // ..init(
//           //   noSurah: noSurah,
//           //   dataQuran: dataQuran,
//           //   startScroll: startScroll ?? false,
//           //   controller: controller,
//           // ),
//           ,
//         ),
//       ],
//       child: BlocBuilder<SurahInfoCubit, SurahInfoState>(
//         builder: (context, state) {
//           if (state is SurahInfoLoaded) {
//             return BasePage.noPadding(
//               appBar: CustomAppBar(
//                 title: state.title,
//                 actions: [
//                   IconButton(
//                     onPressed: () {
//                       // ignore: inference_failure_on_function_invocation
//                       showSearchAyahDialog(
//                         context,
//                         searchAyahController,
//                         controller,
//                         state.totalAyat,
//                       );
//                     },
//                     icon: Icon(
//                       Icons.search,
//                       color: backgroundColor,
//                     ),
//                   ),
//                 ],
//               ),
//               child: state.ayatSurah.isNotEmpty
//                   ? Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       child: ScrollablePositionedList.builder(
//                         itemScrollController: controller,
//                         shrinkWrap: true,
//                         itemPositionsListener: ItemPositionsListener.create(),
//                         itemCount: state.ayatSurah.length + 2,
//                         itemBuilder: (context, index) {
//                           if (index == 0) {
//                             return SurahInfo(
//                               numberSurah: state.numberSurah,
//                               title: state.title,
//                               translation: state.translation,
//                               revelation: state.revelation.toString(),
//                               totalAyat: state.totalAyat,
//                             );
//                           }
//                           index -= 1;
//                           return state.ayatSurah.length != index
//                               ? _buildItem(context, index, state)
//                               : _buildFooter(state);
//                         },
//                       ),
//                     )
//                   : const AppLoading(),
//             );
//           } else {
//             return const AppLoading();
//           }
//         },
//       ),
//     );
//   }

//   Padding _buildFooter(SurahInfoLoaded state) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           if (state.numberSurah != 1)
//             ActionButton(
//               type: ButtonActionType.back,
//               indexSurah: noSurah,
//               dataQuran: dataQuran,
//             )
//           else
//             const SizedBox(),
//           if (state.numberSurah != 114)
//             ActionButton(
//               indexSurah: noSurah,
//               dataQuran: dataQuran,
//               type: ButtonActionType.next,
//             )
//           else
//             const SizedBox(),
//         ],
//       ),
//     );
//   }

class SurahView extends StatefulWidget {
  const SurahView({super.key, required this.selectedSurah, required this.surahList});

  final Surah selectedSurah;
  final List<Surah> surahList;

  @override
  State<SurahView> createState() => _SurahViewState();
}

class _SurahViewState extends State<SurahView> {
  final controller = ItemScrollController();
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
            appBar: CustomAppBar(
              title: widget.selectedSurah.name?.transliteration?.id ?? '',
              actions: [
                IconButton(
                  onPressed: () {
                    // ignore: inference_failure_on_function_invocation
                    showSearchAyahDialog(
                      context,
                      searchAyahController,
                      controller,
                      widget.selectedSurah.numberOfVerses ?? 0,
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: backgroundColor,
                  ),
                ),
              ],
            ),
            child: state.verses.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ScrollablePositionedList.builder(
                      itemScrollController: controller,
                      shrinkWrap: true,
                      itemPositionsListener: ItemPositionsListener.create(),
                      itemCount: state.verses.length + 2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return SurahInfo(surah: widget.selectedSurah);
                        }
                        index -= 1;
                        return widget.selectedSurah.numberOfVerses != index
                            ? _buildItem(context, index, state)
                            : _buildFooter(widget.selectedSurah, widget.surahList);
                      },
                    ),
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

  Widget _buildItem(BuildContext context, int index, SurahLoaded state) {
    // Future<void> setLastRead() async {
    //   final preferences = await Preferences.getInstance();

    //   await preferences.setLastSurahRead(state.numberSurah);
    //   await preferences.setLastAyahRead(index + 1);
    //   // ignore_for_file: use_build_context_synchronously
    //   context.read<SurahInfoCubit>().setLastRead(state, state.numberSurah, index + 1);
    //   ScaffoldMessenger.of(context)
    //     ..removeCurrentSnackBar()
    //     ..showSnackBar(
    //       SnackBar(
    //         content: Text(context.l10n.setLastReadInfo((index + 1).toString())),
    //       ),
    //     );
    // }

    return Stack(
      children: [
        ListTile(
          // onLongPress: setLastRead,
          dense: true,
          contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          tileColor: index.isEven ? backgroundColor : backgroundColorAlter,
          title: RichText(
            textAlign: TextAlign.justify,
            textDirection: TextDirection.rtl,
            text: TextSpan(
              children: [
                TextSpan(
                  text: state.verses[index].ayahText,
                  style: arabicText,
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
          isThreeLine: true,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: state.verses[index].indoText,
                      style: smallText.copyWith(
                        color: backgroundColor2,
                      ),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        // onTap: () => showTafsirBottomSheet(context, state, index),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Icon(
                            Icons.info,
                            size: 15,
                            color: backgroundColor2.withOpacity(.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // if (state.indexLastSurah == state.numberSurah && state.indexLastAyah - 1 == index) ...[
        //   GestureDetector(
        //     // onTap: setLastRead,
        //     child: Icon(
        //       Icons.book_rounded,
        //       color: backgroundColor2,
        //     ),
        //   ),
        // ] else ...[
        GestureDetector(
          // onTap: setLastRead,
          child: Icon(
            Icons.book_outlined,
            color: backgroundColor2.withOpacity(.3),
          ),
        ),
        //   ],
      ],
    );
  }
}
