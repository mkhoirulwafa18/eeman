import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:quran_app/modules/surah_list/presentation/widgets/rub_el_hizb.dart';

class SurahListData extends StatelessWidget {
  const SurahListData({
    super.key,
    required this.dataQuran,
  });

  final List<Surah> dataQuran;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Expanded(
      child: ColoredBox(
        color: backgroundColor,
        child: dataQuran.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: dataQuran.length,
                separatorBuilder: (_, i) => Divider(
                  color: backgroundColor2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return _buildItem(index, context);
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

  ListTile _buildItem(int index, BuildContext context) {
    return ListTile(
      leading: RubElHizb(
        number: dataQuran[index].number.toString(),
      ),
      title: Text(
        dataQuran[index].name?.transliteration?.id ?? '',
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
                    text: dataQuran[index].name?.translation!.id ?? '',
                    style: smallText.copyWith(
                      color: backgroundColor2.withOpacity(0.7),
                    ),
                  ),
                  const WidgetSpan(
                    child: SizedBox(
                      width: 5,
                    ),
                  ),
                  if (dataQuran[index].revelation?.id == Id.MAKKIYYAH)
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
        dataQuran[index].name?.short ?? '',
        style: arabicText,
      ),
      onTap: () {
        // Navigator.push<MaterialPageRoute<dynamic>>(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => SurahPage(
        //       noSurah: dataQuran[index].numberOfSurah! - 1,
        //       dataQuran: dataQuran,
        //     ),
        //   ),
        // );
        // TODO(mkhoirulwafa18): add the correct navigation to surah page
        log('$index ${dataQuran[index].name?.transliteration?.id}');
      },
    );
  }
}
