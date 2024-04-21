// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/surah/presentation/surah_page.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';

import 'package:quran_app/modules/surah_list/presentation/widgets/rub_el_hizb.dart';

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
    final surahs = searchResult ?? surahList;
    return Expanded(
      child: ColoredBox(
        color: backgroundColor,
        child: surahs.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: surahs.length,
                separatorBuilder: (_, i) => Divider(
                  color: backgroundColor2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return _buildItem(index, context, surahs);
                },
              )
            : Expanded(
                child: Center(
                  child: Text(
                    l10n.errorNoSurahFound,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: backgroundColor2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
      ),
    );
  }

  ListTile _buildItem(int index, BuildContext context, List<Surah> resultSurah) {
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
                      child: SvgPicture.asset(
                        '$iconAsset/mecca.svg',
                        width: 12,
                        color: backgroundColor2,
                      ),
                    )
                  else
                    WidgetSpan(
                      child: SvgPicture.asset(
                        '$iconAsset/medina.svg',
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
        log('$index ${resultSurah[index].name?.transliteration?.id}');
      },
    );
  }
}
