// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/themes/text_styles.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      tileColor: Colors.transparent,
      leading: RubElHizb(
        number: resultSurah[index].number.toString(),
      ),
      title: Text(
        resultSurah[index].name?.transliteration?.id ?? '',
        style: context.bodyMedium?.copyWith(
          color: colorScheme.onSurface,
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
                    style: context.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha:0.7),
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
                        color: colorScheme.onSurface,
                      ),
                    )
                  else
                    WidgetSpan(
                      child: Assets.icons.medina.svg(
                        width: 16,
                        color: colorScheme.onSurface,
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
        style: AppTextStyles.arabicText,
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
