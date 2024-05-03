// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/gen/assets.gen.dart';
import 'package:quran_app/modules/surah/presentation/surah_page.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:quran_app/modules/surah_list/presentation/widgets/rub_el_hizb.dart';

class SurahListTile extends StatelessWidget {
  const SurahListTile({
    super.key,
    required this.context,
    required this.index,
    required this.resultSurah,
    required this.surahList,
  });
  final int index;
  final BuildContext context;
  final List<Surah> resultSurah;
  final List<Surah> surahList;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: RubElHizb(
        number: resultSurah[index].number.toString(),
      ),
      title: Text(
        resultSurah[index].name?.transliteration?.id ?? '',
        style: mediumText.copyWith(
          color: backgroundColor2,
        ),
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: resultSurah[index].name?.translation!.id ?? '',
                    style: smallText.copyWith(
                      color: backgroundColor2.withOpacity(0.7),
                    ),
                  ),
                  const WidgetSpan(
                    child: SizedBox(
                      width: 5,
                    ),
                  ),
                  if (resultSurah[index].revelation?.id == Id.MAKKIYYAH)
                    WidgetSpan(
                      child: Assets.icons.mecca.svg(
                        width: 12,
                        color: backgroundColor2,
                      ),
                    )
                  else
                    WidgetSpan(
                      child: Assets.icons.medina.svg(
                        width: 16,
                        color: backgroundColor2,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      dense: true,
      trailing: Text(
        resultSurah[index].name?.short ?? '',
        style: arabicText,
      ),
      onTap: () {
        Navigator.push<MaterialPageRoute<dynamic>>(
          context,
          MaterialPageRoute(
            builder: (context) => SurahPage(
              selectedSurah: resultSurah[index],
              surahList: surahList,
            ),
          ),
        );
      },
    );
  }
}
