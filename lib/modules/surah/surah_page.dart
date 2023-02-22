import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/common/widgets/base_page.dart';
import 'package:quran_app/common/widgets/custom_app_bar.dart';
import 'package:quran_app/modules/surah/cubit/murattal_cubit.dart';
import 'package:quran_app/modules/surah/cubit/surah_info_cubit.dart';
import 'package:quran_app/modules/surah/utils/tafsir_bottomsheet.dart';
import 'package:quran_app/modules/surah/widgets/action_button.dart';
import 'package:quran_app/modules/surah/widgets/surah_info.dart';
import 'package:quran_app/modules/surah_list/models/quran.dart';
import 'package:quran_app/modules/surah_list/widgets/rub_el_hizb.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahPage extends StatelessWidget {
  SurahPage({
    super.key,
    required this.noSurah,
    required this.dataQuran,
    this.startAyat = 0,
  });
  final int noSurah;
  final List<Quran> dataQuran;
  final int? startAyat;
  final controller = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MurattalCubit(),
        ),
        BlocProvider(
          create: (context) => SurahInfoCubit()..init(noSurah, dataQuran),
        ),
      ],
      child: BlocBuilder<SurahInfoCubit, SurahInfoState>(
        builder: (context, state) {
          if (state is SurahInfoLoaded) {
            return BasePage.noPadding(
              appBar: CustomAppBar(title: state.title),
              child: state.ayatSurah.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ScrollablePositionedList.builder(
                        itemScrollController: controller,
                        shrinkWrap: true,
                        itemPositionsListener: ItemPositionsListener.create(),
                        itemCount: state.ayatSurah.length + 2,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return SurahInfo(
                              numberSurah: state.numberSurah,
                              title: state.title,
                              translation: state.translation,
                              revelation: state.revelation.name,
                              totalAyat: state.totalAyat,
                            );
                          }
                          index -= 1;
                          return state.ayatSurah.length != index
                              ? _buildItem(context, index, state)
                              : _buildFooter(state);
                        },
                      ),
                    )
                  : const AppLoading(),
            );
          } else {
            return const AppLoading();
          }
        },
      ),
    );
  }

  Padding _buildFooter(SurahInfoLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (state.numberSurah != 1)
            ActionButton(
              type: ButtonActionType.back,
              indexSurah: noSurah,
              dataQuran: dataQuran,
            )
          else
            const SizedBox(),
          if (state.numberSurah != 114)
            ActionButton(
              indexSurah: noSurah,
              dataQuran: dataQuran,
              type: ButtonActionType.next,
            )
          else
            const SizedBox()
        ],
      ),
    );
  }

  ListTile _buildItem(BuildContext context, int index, SurahInfoLoaded state) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.all(16),
      tileColor: index.isEven ? backgroundColor : backgroundColorAlter,
      title: RichText(
        textAlign: TextAlign.justify,
        textDirection: TextDirection.rtl,
        text: TextSpan(
          children: [
            TextSpan(
              text: (index == 0 && state.numberSurah != 1
                      ? state.ayatSurah[index].text!.substring(39)
                      : state.ayatSurah[index].text) ??
                  '',
              style: arabicText,
            ),
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: RubElHizb(
                  number: (index + 1).toString(),
                ),
              ),
            )
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
                  text: state.ayatSurah[index].translationId ?? '',
                  style: smallText.copyWith(
                    color: backgroundColor2,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () => showTafsirBottomSheet(context, state, index),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.info,
                        size: 15,
                        color: backgroundColor2.withOpacity(.5),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
